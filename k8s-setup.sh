#!/bin/bash
# 
# Install docker and kubernetes tools
# run as root with curl -fsSL https://raw.githubusercontent.com/nunesvictor/k8s-setup/master/k8s-setup.sh | bash

# disable swap
swapoff -a
sed -e '/swap/s/^/#/g' -i /etc/fstab

# ensure legacy binaries are installed
apt-get update && \
apt-get install -y iptables arptables ebtables

# switch to legacy versions
update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
update-alternatives --set arptables /usr/sbin/arptables-legacy
update-alternatives --set ebtables /usr/sbin/ebtables-legacy

# install apt-transport-https and curl
apt-get install -y apt-transport-https curl

# install docker
curl -fsSL https://get.docker.com | bash

# install kubeadm, kubelet and kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF | tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
