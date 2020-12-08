## Making Storage Class as default
```
kubectl patch storageclass managed-nfs-storage -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

### Script for auto change master IP and upgrade the helm list
```
#!/bin/bash

echo "Getting Ip of K8s Master"
new_ip=$( ssh -o StrictHostKeyChecking=no -l root master  "curl -s ifconfig.co" )
echo $new_ip
old_ip=$(cat /home/ubuntu/nfs-dynamic/values.yaml | grep "nfs_server" | cut -d ' ' -f2)
echo "Setting IP of Values.yaml"
sed -i 's/'$old_ip'/'$new_ip'/' /home/ubuntu/nfs-dynamic/values.yaml
helm upgrade nfs-dynamic /home/ubuntu/nfs-dynamic/.
```
