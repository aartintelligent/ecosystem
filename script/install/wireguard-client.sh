#!/bin/bash

SERVER_IP=""
SERVER_PORT="51820"
CLIENT_ADDRESS="10.0.0.2/24"
INTERFACE="wg0"
WIREGUARD_DIR="/opt/wireguard"

function helper {
  echo "Usage: $0 --client-address <client_address> --server-ip <server_ip> [--server-port <server_port>] [--interface <interface_name>]"
  echo ""
  echo "Options:"
  echo "  --client-address  The IP address assigned to the WireGuard client"
  echo "  --server-ip       The public IP address of the WireGuard server"
  echo "  --server-port     (Optional) The WireGuard server listening port (default: 51820)"
  echo "  --interface       (Optional) The name of the WireGuard network interface (default: wg0)"
}

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --client-address)
      CLIENT_ADDRESS="$2"
      shift
      shift
      ;;
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
    --interface)
      INTERFACE="$2"
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
  echo "This script must be performed with superuser privileges."
  exit 1
fi

mkdir -p $WIREGUARD_DIR

if [ ! -f "$WIREGUARD_DIR/private.key" ]; then
  wg genkey > $WIREGUARD_DIR/private.key
fi

if [ ! -f "$WIREGUARD_DIR/public.key" ]; then
  wg pubkey < $WIREGUARD_DIR/private.key > $WIREGUARD_DIR/public.key
fi

# Configuration du client WireGuard
cat << EOF > "/etc/wireguard/$INTERFACE.conf"
[Interface]
PrivateKey = $(cat $WIREGUARD_DIR/private.key)
Address = $CLIENT_ADDRESS

[Peer]
PublicKey = $(cat /opt/wireguard/public.key)
Endpoint = $SERVER_IP:$SERVER_PORT
AllowedIPs = 0.0.0.0/0
EOF

systemctl enable --now "wg-quick@$INTERFACE.service"

echo "The WireGuard client has been successfully installed and configured."
