#!/bin/bash
set -e

directory="/etc/ssmtp"

while IFS= read -r file; do

  for e in "${!SSTMP_@}"; do

    sed -i -e 's!__'"$e"'__!'"$(printenv "$e")"'!g' "$file"

  done

done < <(find "$directory" -name "*.conf")

touch /etc/ssmtp/ssmtp.conf.tmp

while IFS= read -r line; do

  if [[ "$line" =~ .*=$ ]]; then

    echo "#$line" >> /etc/ssmtp/ssmtp.conf.tmp

    continue

  fi

  echo "$line" >> /etc/ssmtp/ssmtp.conf.tmp

done </etc/ssmtp/ssmtp.conf

mv /etc/ssmtp/ssmtp.conf.tmp /etc/ssmtp/ssmtp.conf

rm -f /etc/ssmtp/ssmtp.conf.tmp

(>&2 echo "[*] Bootstrap SSTMP")
