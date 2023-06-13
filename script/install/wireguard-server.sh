#!/bin/bash

PRIVATE_KEY=""
SERVER_IP=""
SERVER_PORT="51820"
CLIENTS_SUBNET="10.0.0.0/24"
INTERFACE="wg0"
EXTERNAL_INTERFACE="eth0"
MTU="1420"
WIREGUARD_DIR="/opt/wireguard"

function helper {
  echo "Usage: $0 --server-ip <server_ip> [--server-port <server_port>] [--clients-subnet <clients_subnet>] [--interface <interface_name>] [--external-interface <external_interface>] [--mtu <mtu>]"
  echo ""
  echo "Options:"
  echo "  --server-ip           The public IP address of the WireGuard server"
  echo "  --server-port         (Optional) The WireGuard server listening port (default: 51820)"
  echo "  --clients-subnet      (Optional) The subnet of IP addresses assigned to WireGuard clients (default: 10.0.0.0/24)"
  echo "  --interface           (Optional) The name of the WireGuard network interface (default: wg0)"
  echo "  --external-interface  (Optional) The name of the external network interface (default: eth0)"
  echo "  --mtu                 (Optional) The MTU (Maximum Transmission Unit) value for the WireGuard interface (default: 1420)"
}

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --server-ip)
      SERVER_IP="$2"
      shift
      shift
      ;;
    --server-port)
      SERVER_PORT="$2"
      shift
      shift
      ;;
    --clients-subnet)
      CLIENTS_SUBNET="$2"
      shift
      shift
      ;;
    --interface)
      INTERFACE="$2"
      shift
      shift
      ;;
    --external-interface)
      EXTERNAL_INTERFACE="$2"
      shift
      shift
      ;;
    --mtu)
      MTU="$2"
      shift
      shift
      ;;
    *)
      helper
      exit 1
      ;;
  esac
done

if [ -z "$SERVER_IP" ]; then
  helper
  exit 1
fi

if [ "$EUID" -ne 0 ]; then
  echo "This script must be executed with superuser privileges."
  exit 1
fi

mkdir -p $WIREGUARD_DIR

PRIVATE_KEY=$(wg genkey)
echo "$PRIVATE_KEY" > $WIREGUARD_DIR/private.key

PUBLIC_KEY=$(echo "$PRIVATE_KEY" | wg pubkey)
echo "$PUBLIC_KEY" > $WIREGUARD_DIR/public.key

cat << EOF > /etc/wireguard/"$INTERFACE".conf
[Interface]
PrivateKey = $(cat $WIREGUARD_DIR/private.key)
Address = $SERVER_IP
ListenPort = $SERVER_PORT
MTU = $MTU
PostUp = $WIREGUARD_DIR/post-up.sh
PostDown = $WIREGUARD_DIR/post-down.sh
SaveConfig = true

EOF

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.d/10-wireguard.conf

sysctl --system > /dev/null

cat << EOF > $WIREGUARD_DIR/post-up.sh
#!/bin/bash

iptables -A FORWARD -i $INTERFACE -j ACCEPT
iptables -t nat -A POSTROUTING -o $EXTERNAL_INTERFACE -j MASQUERADE

EOF

chmod +x $WIREGUARD_DIR/post-up.sh

cat << EOF > $WIREGUARD_DIR/post-down.sh
#!/bin/bash

iptables -D FORWARD -i $INTERFACE -j ACCEPT
iptables -t nat -D POSTROUTING -o $EXTERNAL_INTERFACE -j MASQUERADE

EOF

chmod +x $WIREGUARD_DIR/post-down.sh

systemctl enable --now "wg-quick@$INTERFACE.service"

echo "The WireGuard server has been successfully installed and configured."
