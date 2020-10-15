#######################################################################
#### Installation of kubeadm and docker for kubernetes worker node ####
################# system compatible Ubuntu:18.04.5 LTS (Bionic Beaver) #######################
####################   Maintainer: Adil Khan  #########################
############### To Run this script ####################################
### curl -s https://raw.githubusercontent.com/adil1806/play-with-kubectl/master/kubernetes-worker-node.sh | bash ####
###########################################################################################################################

#!/bin/bash
echo "[TASK 1] Updating system"
apt-get update >/dev/null 2>&1

echo "[TASK 2] Install Transport HTTPS"
apt-get install -y apt-transport-https >/dev/null 2>&1

echo "[TASK 3] Adding key for Docker"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable
EOF

apt-get update >/dev/null 2>&1

echo "[TASK 4] Installing Docker"
apt-get install -y docker.io >/dev/null 2>&1

systemctl stop docker
modprobe overlay
echo '{"storage-driver": "overlay2"}' > /etc/docker/daemon.json
rm -rf /var/lib/docker/*
systemctl start docker

echo "[TASK 5] Installing Tools for K8s"
# Install kubernetes components!
apt-get install -y \
        kubelet \
        kubeadm \
        kubernetes-cni \
        nfs-common >/dev/null 2>&1
# nfs-common util for nfs dynamic provisioning
