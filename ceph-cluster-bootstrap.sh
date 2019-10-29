#

if [[ $# -lt 1 ]]; echo "Usage: $0 <master-node> [<nodes>...]"; exit -1; fi

# create folder for configs and credentials
mkdir ceph-cluster
cd ceph-cluster

# create the cluster
ceph-deploy new $1

# install ceph on all nodes
ceph-deploy install $@

# deploy initial monitors and gather keys
ceph-deploy mon create-initial

# copy config and admin keys
ceph-deploy admin $@

# deploy manager deamon
ceph-deploy mgr create $1

echo -e "Now add OSDs to the ceph cluster to complete setup."
echo -e "Create an MDS if CephFS is needed."
