### Setting up K8s Cluster using LXC/LXD 

```
For running LXC create a EC2 instance of t2.medium size this will sufficient for running LXC wth 3 nodes, each of 2 CPU's and 2Gi of memory.
```
#### Installing the LXC on Ubuntu 
```
➤ ➤ ADIL ~  sudo apt-get update && apt-get install lxc -y
➤ ➤ ADIL ~  systemctl status lxc
➤ ➤ ADIL ~  lxd init
Provide default option for all excepy these two line:
Name of the storage backend to use (btrfs, dir, lvm) [default=btrfs]: dir
Would you like LXD to be available over the network? (yes/no) [default=no]: yes
```
#### Let's create profile for k8s cluster
```
➤ ➤ ADIL ~  lxc profile copy default k8s
➤ ➤ ADIL ~  lxc profile edit k8s
Copy the config line from file k8s-profile-config and paste
config:
  limits.cpu: "2"
  limits.memory: 2GB
  limits.memory.swap: "false"
  linux.kernel_modules: ip_tables,ip6_tables,netlink_diag,nf_nat,overlay
  raw.lxc: "lxc.apparmor.profile=unconfined\nlxc.cap.drop= \nlxc.cgroup.devices.allow=a\nlxc.mount.auto=proc:rw
    sys:rw"
  security.nesting: "true"
  security.privileged: "true"

```
