### Install samba server:
```
$ sudo apt update && sudo apt install samba
$ mkdir /smb
$ chmod 777 /smb
$ sudo vim /etc/samba/smb.conf
add this: [my-smb-share]
        	path = /smb
      		public = no
        	valid users = adil pyrus
        	read list = pyrus
        	write list = adil
        	browseable = yes
        	comment = "My samba file server"

$ sudo testparm
$ sudo useradd pyrus -s /sbin/nologin
$ sudo useradd adil -s /sbin/nologin
$ sudo smbpasswd -a adil
$ sudo smbpasswd -a pyrus
$ sudo systemctl start smbd
$ sudo systemctl start smbd
$ sudo systemctl enable smbd nmbd
```

### Client Side:
###### ping 3.20.63.104 //ip of samba server
```
$ yum -y install samba samba-client cifs-utils
$ mount -t cifs -o user=adil,password=123 //3.20.63.104/my-smb-share /mnt
$ cd /mnt/
$ df -HT
Filesystem                 Type      Size  Used Avail Use% Mounted on
//3.20.63.104/my-smb-share cifs       30G  5.6G   24G  20% /mnt
```
