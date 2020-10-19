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

#### Burstable (QoS)
```
Pods have some form of minimal resource guarantee, but can use more resources when available. Under system memory pressure, these containers are more likely to be killed once they exceed their requests and no Best-Effort pods exist.
If requests and optionally limits are set (not equal to 0) for one or more resources across one or more containers, and they are not equal, then the pod is classified as Burstable. When limits are not specified, they default to the node capacity.

➤ ➤ ADIL kubernetes-qos git:(master) * *  kubectl apply -f pod-burstable.yaml
pod/nginx created

➤ ➤ ADIL kubernetes-qos git:(master) * *  kubectl describe pods nginx | grep -i "qos"
QoS Class:       Burstable
```

#### Best-Effort (QoS)
```
Pods will be treated as lowest priority. Processes in these pods are the first to get killed if the system runs out of memory. These containers can use any amount of free memory in the node though.
If requests and limits are not set for all of the resources, across all containers, then the pod is classified as Best-Effort.

➤ ➤ ADIL kubernetes-qos git:(master) * *  kubectl create -f pod-best-effort.yaml
pod/nginx created

➤ ➤ ADIL kubernetes-qos git:(master) * *  kubectl describe pods nginx | grep -i "qos"
QoS Class:       BestEffort
```
