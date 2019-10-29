ADDRS="$1"; for e in ${@:2}; do ADDRS+=",$e"; done
sed "s/{IP:PORT}/$ADDRS/g" rbd-storage-class.yaml
