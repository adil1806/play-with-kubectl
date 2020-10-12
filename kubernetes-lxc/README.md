### Setting up K8s Cluster using LXC/LXD 

```
For running LXC create a EC2 instance of t2.medium size this will sufficient for running LXC wth 3 nodes, each of 2 CPU's and 2Gi of memory.
```
#### Installing the LXC on Ubuntu 
```
➤ ➤ ADIL ~  sudo apt-get update && apt-get install lxc -y
➤ ➤ ADIL ~  systemctl status lxc
➤ ➤ ADIL ~  lxd init
Would you like to use LXD clustering? (yes/no) [default=no]:
Do you want to configure a new storage pool? (yes/no) [default=yes]:
Name of the new storage pool [default=default]:
The requested storage pool "default" already exists. Please choose another name.
Name of the new storage pool [default=default]:
The requested storage pool "default" already exists. Please choose another name.
Name of the new storage pool [default=default]: k8s
Name of the storage backend to use (btrfs, dir, lvm) [default=btrfs]: dir
Would you like to connect to a MAAS server? (yes/no) [default=no]:
Would you like to create a new local network bridge? (yes/no) [default=yes]:
What should the new bridge be called? [default=lxdbr0]: lxdbr1
What IPv4 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]:
What IPv6 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]:
#Would you like LXD to be available over the network? (yes/no) [default=no]: yes#
Address to bind LXD to (not including port) [default=all]:
Port to bind LXD to [default=8443]:
Trust password for new clients:
Again:
No password set, client certificates will have to be manually trusted.Would you like stale cached images to be updated automatically? (yes/no) [default=yes]

➤ ➤ ADIL ~  lxc profile copy default k8s
➤ ➤ ADIL ~  lxc profile edit k8s
Copy the config line from file k8s-profile-config and paste
➤ ➤ ADIL ~  lxc profile show k8s
config:
  limits.cpu: "2"
  limits.memory: 2GB
  limits.memory.swap: "false"
  linux.kernel_modules: ip_tables,ip6_tables,netlink_diag,nf_nat,overlay
  raw.lxc: "lxc.apparmor.profile=unconfined\nlxc.cap.drop= \nlxc.cgroup.devices.allow=a\nlxc.mount.auto=proc:rw
    sys:rw"
  security.nesting: "true"
  security.privileged: "true"
description: Default LXD profile
devices:
  eth0:
    name: eth0
    nictype: bridged
    parent: lxdbr1
    type: nic
  root:
    path: /
    pool: k8s
    type: disk
name: k8s
used_by: []

```
