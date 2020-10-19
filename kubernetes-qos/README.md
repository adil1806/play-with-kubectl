#### Quality of Service (QoS) Classes in Kubernetes

#### Guaranteed (QoS)
```
Pods are considered top-priority and are guaranteed to not be killed until they exceed their limits.
If limits and optionally requests (not equal to 0) are set for all resources across all containers and they are equal, then the pod is classified as Guaranteed.

➤ ➤ ADIL kubernetes-qos git:(master)  kubectl create -f pod-guaranteed.yaml
pod/nginx created

➤ ➤ ADIL kubernetes-qos git:(master)  kubectl describe pods nginx | grep -i "qos"
QoS Class:       Guaranteed
```
