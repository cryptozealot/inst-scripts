# remove k8s installation
# use root because its cool
swapoff -a
kubeadm reset
apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*   
apt-get autoremove  
rm -rf ~/.kube

# remove all kubernetes related folders 
rm -rf /etc/ceph \
       /etc/cni \
       /etc/kubernetes \
       /opt/cni \
       /opt/rke \
       /run/secrets/kubernetes.io \
       /run/calico \
       /run/flannel \
       /var/lib/calico \
       /var/lib/etcd \
       /var/lib/cni \
       /var/lib/kubelet \
       /var/lib/rancher/rke/log \
       /var/log/containers \
       /var/log/pods \
       /var/run/calico

# install kubelete, kubeadm, kubernetes-cli
apt-get update && apt-get install -y kubelet kubeadm kubernetes-cni

# install docker.io
apt-get install -y apt-transport-https
apt-get install -qy docker.io
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
apt-get update

# turnoff swap
apt-get update
apt-get upgrade
swapoff -a

#init k8s cluster
kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf
sysctl net.bridge.bridge-nf-call-iptables=1
export kubever=$(kubectl version | base64 | tr -d '\n')
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"

# taint node
kubectl taint nodes --all node-role.kubernetes.io/master-

# install helm and tiller
curl -LO https://git.io/get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller

# install prometheus-operator
helm install stable/prometheus-operator

#expose grafana and access it with user:admin pass:prom-operator
