KEY=`sudo ceph --cluster ceph auth get-key client.admin`
echo -e 'kubectl create secret generic ceph-secret \\\n    --type="kubernetes.io/rbd" \\\n    --from-literal=key='$KEY' \\\n    --namespace=kube-system'
