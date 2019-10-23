#!/bin/bash

# usage
if [[ $# -lt 1 ]] ; then echo -e "Usage: $0 <user@hosts>...\nInitlalizes the ceph account on target hosts, requires an existing sudo user"; exit -1; fi

# must execute as the ceph user
if [[ `whoami` != "ceph" ]] ; then echo "Must execute as the ceph user!"; exit -1; fi

# create ssh key pairs if necessary
if [[ ! -f ~/.ssh/id_rsa ]]; then ssh-keygen; fi

for i in ${@}; do

    USERNAME=`echo $i | cut -d '@' -f 1`;
    HOST=`echo $i | cut -d '@' -f 2`;
    echo $USERNAME@$HOST

    # create ceph user and add priviledges
    ssh -t $USERNAME@$HOST -- bash < ceph-node-setup-account.sh;
    ssh-copy-id ceph@$HOST;

    # execute setup script as ceph user
    ssh -t ceph@$HOST -- bash < ceph-node-setup-local.sh;
done
