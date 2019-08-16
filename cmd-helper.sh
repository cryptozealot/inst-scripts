#!/bin/bash
#chmod this script, execute it and source it to be able to use it

echo "source <(kubectl completion bash)
alias k='kubectl'
complete -F __start_kubectl k
alias kn='namespaceset'
alias brc='source ~/.bashrc'"  >> ~/.bashrc

echo "namespace=\$1
kubectl config set-context --current --namespace=\$1
kubectl config view | grep namespace"  >> /bin/namespaceset

chmod +x /bin/namespaceset

#Source the changes in .bashrc using the commands below

#source ~/.bashrc
#source /root/.bashrc
#brc

## Use commands below manually
########### docker exec into container

#container_name_or_id=$1
#docker exec -it $1 /bin/bash

########## kubectl exec into container

#container=$1
#kubectl exec -it $1 -- /bin/bash
#kubectl exec -it $1 -- /bin/sh
