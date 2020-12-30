#!/bin/bash

## Info
echo "[TASK 1] Installing all updates, this may take a few minutes ...";
apt-get update -y >/dev/null 2>&1

## Install NFS
echo "[TASK 2] Installing NFS ...";
apt-get install nfs-kernel-server -y >/dev/null 2>&1


## NFS Folders
echo "[TASK 3] Creating/Adjusting Folder /nfs-demo and editing /etc/exports ...";

mkdir /nfs-demo >/dev/null 2>&1
chmod -R 755 /nfs-demo >/dev/null 2>&1
chown nobody:nogroup /nfs-demo 
echo "/nfs-demo *(rw,sync,no_root_squash,no_all_squash)" >> /etc/exports

## Restart Services
echo "[TASK 4] Restarting Services ...";
service nfs-kernel-server restart >/dev/null 2>&1
