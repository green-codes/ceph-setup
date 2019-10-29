sudo ceph --cluster ceph osd pool create kube 32 32
sudo ceph --cluster ceph auth get-or-create client.kube mon 'allow r' osd 'allow rwx pool=kube'

KEY=`sudo ceph --cluster ceph auth get-key client.kube`
echo -e "\nUse the following to create a kube secret for the 'kube' pool in ceph\n"
echo -e 'kubectl create secret generic ceph-secret-kube \\\n    --type="kubernetes.io/rbd" \\\n    --from-literal=key='$KEY' \\\n    --namespace=kube-system'
