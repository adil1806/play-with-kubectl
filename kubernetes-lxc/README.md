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
#### It's time to create node for k8s cluster
```
➤ ➤ ADIL ~  lxc launch images:centos/7 kmaster --profile k8s
Creating kmaster
Starting kmaster
➤ ➤ ADIL ~  lxc launch images:centos/7 kworker01 --profile k8s
Creating kworker01
Starting kworker01
➤ ➤ ADIL ~  lxc launch images:centos/7 kworker02 --profile k8s
Creating kworker02
Starting kworker02

List the node:
➤ ➤ ADIL ~  lxc list
+-----------+---------+-----------------------+----------------------------------------------+------------+-----------+
|   NAME    |  STATE  |         IPV4          |                     IPV6                     |    TYPE    | SNAPSHOTS |
+-----------+---------+-----------------------+----------------------------------------------+------------+-----------+
| kmaster   | RUNNING | 10.127.221.187 (eth0) | fd42:d04d:d3e7:433:216:3eff:fe61:e128 (eth0) | PERSISTENT | 0         |
+-----------+---------+-----------------------+----------------------------------------------+------------+-----------+
| kworker01 | RUNNING | 10.127.221.49 (eth0)  | fd42:d04d:d3e7:433:216:3eff:fef8:af2d (eth0) | PERSISTENT | 0         |
+-----------+---------+-----------------------+----------------------------------------------+------------+-----------+
| kworker02 | RUNNING | 10.127.221.151 (eth0) | fd42:d04d:d3e7:433:216:3eff:fe28:77dc (eth0) | PERSISTENT | 0         |
+-----------+---------+-----------------------+----------------------------------------------+------------+-----------+
```
#### Now run bootstrap script on all node.
```
It is mandatory on run this bootstrap script on master node first.
➤ ➤ ADIL kubernetes-lxc git:(master)  cat bootstrap-kube.sh| lxc exec kmaster bash
➤ ➤ ADIL kubernetes-lxc git:(master)  cat bootstrap-kube.sh| lxc exec kworker01 bash
➤ ➤ ADIL kubernetes-lxc git:(master)  cat bootstrap-kube.sh| lxc exec kworker02 bash
This will take some time... Just Relax :)
```
