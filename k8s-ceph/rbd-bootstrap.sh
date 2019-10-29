#

if [[ $# -lt 1 ]]; then echo "Usage: $0 <ceph-monitor-ip:port>..."; exit -1; fi

# create the rbd-provisioner deplyment and set associated permissions
kubectl create -n kube-system -f rbd-provisioner.yaml

# create kube pool in ceph, add ceph secrets to kubernetes
echo "`bash get-ceph-admin-keystring.sh`" | bash
echo "`bash get-ceph-kube-client.sh`" | bash

# create the rbd storage class
ADDRS="$1"; for e in ${@:2}; do ADDRS+=",$e"; done
sed "s/{IP:PORT}/$ADDRS/g" rbd-storage-class.yaml | kubectl create -f -

# create pvc
echo "Create a RBD-based PVC using rbd-pvc.yaml"
