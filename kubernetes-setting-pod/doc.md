1. Check the description of node. Before it was 110 pod can schedule on this worker node
   ➤ ➤ ADIL ubuntu  kubectl describe no ip-172-31-32-180 | grep -i pods
  pods:               110          
1. First login to worker node.
2. sudo systemctl status kubelet
3. You will get this output
  CGroup: /system.slice/kubelet.service
           └─4826 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml
4. Now, edit this /var/lib/kubelet/config.yaml file
  root@ip-172-31-32-180:/home/ubuntu# sudo vim /var/lib/kubelet/config.yaml
  search for maxPods
  If not present then add:
    maxPods: 10  [ no. of pod want to schedule ]
5. Save file and restart kubelet service.
   sudo systemctl restart kubelet
6. Now, Check pod on worker node
➤ ➤ ADIL ubuntu  kubectl describe no ip-172-31-32-180 | grep -i pods
  pods:               10
