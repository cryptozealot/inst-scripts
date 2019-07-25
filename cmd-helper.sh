########## put this in ~/.bashrc

source <(kubectl completion bash)
alias k='kubectl'
complete -F __start_kubectl k
alias kn='namespaceset'

########## k8s namespace selector script: /bin/namespaceset.sh

namespace=$1
kubectl config set-context --current --namespace=$1
kubectl config view | grep namespace


########## docker exec into container

container_name_or_id=$1
docker exec -it $1 /bin/bash

########## kubectl exec into container

container=$1
kubectl exec -it $1 -- /bin/bash
kubectl exec -it $1 -- /bin/sh
