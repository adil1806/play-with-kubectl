############################################################# PLAY WITH KUBECTL #############################################################################
#       Installation of nfs and setting /nfs-private in /etc/exports
#       system compatible: Ubuntu:18.04.5 LTS (Bionic Beaver) and 20.04.1 LTS (Focal Fossa).     
#       Maintainer: Adil Abdullah Khan  
#       To Run this script:
#       curl  https://raw.githubusercontent.com/adil1806/play-with-kubectl/master/kubernetes-installation/Install-nfs.sh | bash
#############################################################################################################################################################
#!/bin/bash

## Info
echo "[TASK 1] Installing all updates, this may take a few minutes ..."
apt-get update -y >/dev/null 2>&1

## Install NFS
echo "[TASK 2] Installing NFS ..."
apt-get install nfs-kernel-server -y >/dev/null 2>&1


## NFS Folders
echo "[TASK 3] Creating/Adjusting Folder /nfs-private and editing /etc/exports ..."

mkdir /nfs-private >/dev/null 2>&1
chmod -R 755 /nfs-private >/dev/null 2>&1
chown nobody:nogroup /nfs-private
echo "/nfs-private *(rw,sync,no_root_squash,no_all_squash)" >> /etc/exports

## Restart Services
echo "[TASK 4] Restarting Services ..."
service nfs-kernel-server restart >/dev/null 2>&1
