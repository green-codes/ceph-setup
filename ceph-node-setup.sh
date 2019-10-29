#!/bin/bash

# usage
if [[ $# -lt 1 ]] ; then echo -e "Usage: $0 <user@hosts>...\nInitlalizes the ceph account on target hosts, requires an existing sudo user"; exit -1; fi

# must NOT execute as the ceph user
if [[ `whoami` == "ceph" ]] ; then echo "Cannot execute as the ceph user!"; exit -1; fi

# create ssh key pairs if necessary
if [[ ! -f ~/.ssh/id_rsa ]]; then ssh-keygen; fi

for i in ${@}; do

    # setup password-less ssh
    ssh-copy-id $i
    ssh -t $i -- bash < ceph-node-setup-account.sh;

    # execute setup script
    ssh -t $i -- bash < ceph-node-setup-local.sh;

done
