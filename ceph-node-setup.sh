#!/bin/bash

# usage
if [[ $# -lt 1 ]] ; then echo -e "Usage: $0 <user@hosts>...\nSet up password-less ssh for existing sudo users on each specified node"; exit -1; fi

# must NOT execute as the ceph user
if [[ `whoami` == "ceph" ]] ; then echo "Cannot execute as the ceph user!"; exit -1; fi

# create ssh key pairs if necessary
if [[ ! -f ~/.ssh/id_rsa ]]; then ssh-keygen; fi

for i in ${@}; do

    ssh-copy-id $i
    ssh -t $i -- "cd ~ && git clone https://github.com/green-codes/ceph-setup.git"
    ssh -t $i -- "bash ~/ceph-setup/ceph-node-setup-account.sh"
    ssh -t $i -- "bash ~/ceph-setup/ceph-node-setup-local.sh"

done
