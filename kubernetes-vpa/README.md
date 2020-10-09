# Vertical Pod Autoscaler

Vertical Pod autoscaling frees you from having to think about what values to specify for a container's CPU and memory requests. The autoscaler can recommend values for CPU and memory requests and limits, or it can automatically update the values.

### Prerequisites

```
Metrics server
VP Autoscaler
```

### Installing

```
If you have not installed metrics server on your cluster then you will get this errors:
kubectl top pods
error: Metrics API not available

kubectl top nodes
error: Metrics API not available
```
Installing Metrics server:

```
Clone this directory for Metrics server:
https://github.com/adil1806/play-with-kubectl/tree/master/kubernetes-metrics-server/metrics-v1.8
OR 
pwd
/root/play-with-kubectl/kubernetes-vpa/metrics-server:v1.8

kubectl create -f .
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator created
rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader created
Warning: apiregistration.k8s.io/v1beta1 APIService is deprecated in v1.19+, unavailable in v1.22+; use apiregistration.k8s.io/v1 APIService
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created
serviceaccount/metrics-server created
deployment.apps/metrics-server created
service/metrics-server created
clusterrole.rbac.authorization.k8s.io/system:metrics-server created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server created

Verify the metrics deployed or not:
kubectl get pods -n kube-system | grep metrics
metrics-server-7d58cbc7df-xzcf6       1/1     Running   0          74s

Let's verify using kubectl top command:
kubectl top nodes
NAME        CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
kworker01   22m          2%     494Mi           56%
kworker02   26m          2%     531Mi           60%
kworker03   28m          2%     480Mi           54%
master      1260m        63%    1822Mi          47%

kubectl top pods -A
NAMESPACE     NAME                                  CPU(cores)   MEMORY(bytes)
kube-system   coredns-f9fd979d6-7cxzs               3m           13Mi
kube-system   coredns-f9fd979d6-nsbw4               3m           13Mi
kube-system   ebs-csi-controller-749fd878c4-5jhlk   1m           34Mi
kube-system   ebs-csi-controller-749fd878c4-pbv6q   2m           30Mi
kube-system   ebs-csi-node-d75nk                    1m           19Mi
kube-system   ebs-csi-node-p2kms                    1m           22Mi
kube-system   ebs-csi-node-pfbkb                    1m           14Mi
kube-system   ebs-csi-node-pkbn5                    1m           12Mi
kube-system   etcd-master                           15m          93Mi
kube-system   kube-apiserver-master                 46m          326Mi
kube-system   kube-controller-manager-master        15m          53Mi
kube-system   kube-flannel-ds-2zv5t                 2m           13Mi
kube-system   kube-flannel-ds-6vw5f                 2m           18Mi
kube-system   kube-flannel-ds-j75mk                 2m           12Mi
kube-system   kube-flannel-ds-qtc9z                 2m           14Mi
kube-system   kube-proxy-69tnc                      1m           24Mi
kube-system   kube-proxy-8b68q                      1m           18Mi
kube-system   kube-proxy-q4tmj                      1m           15Mi
kube-system   kube-proxy-xrdt5                      1m           20Mi
kube-system   kube-scheduler-master                 3m           21Mi
kube-system   metrics-server-7d58cbc7df-xzcf6       1m           12Mi


Till here we deploy metrics server on out cluster..
```
Installing  VP Autoscaler:
```
Clone this repo: https://github.com/kubernetes/autoscaler.git
or this repo already present on my repo.

pwd
/root/play-with-kubectl/kubernetes-vpa/autoscaler/vertical-pod-autoscaler/hack

There was a script vpa-up.sh for custom deploy of VPA
Run this script.

./vpa-up.sh
Warning: apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
customresourcedefinition.apiextensions.k8s.io/verticalpodautoscalers.autoscaling.k8s.io created
customresourcedefinition.apiextensions.k8s.io/verticalpodautoscalercheckpoints.autoscaling.k8s.io created
clusterrole.rbac.authorization.k8s.io/system:metrics-reader created
clusterrole.rbac.authorization.k8s.io/system:vpa-actor created
clusterrole.rbac.authorization.k8s.io/system:vpa-checkpoint-actor created
clusterrole.rbac.authorization.k8s.io/system:evictioner created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-reader created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-actor created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-checkpoint-actor created
clusterrole.rbac.authorization.k8s.io/system:vpa-target-reader created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-target-reader-binding created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-evictionter-binding created
serviceaccount/vpa-admission-controller created
clusterrole.rbac.authorization.k8s.io/system:vpa-admission-controller created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-admission-controller created
clusterrole.rbac.authorization.k8s.io/system:vpa-status-reader created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-status-reader-binding created
serviceaccount/vpa-updater created
deployment.apps/vpa-updater created
serviceaccount/vpa-recommender created
deployment.apps/vpa-recommender created
Generating certs for the VPA Admission Controller in /tmp/vpa-certs.
Generating RSA private key, 2048 bit long modulus (2 primes)
.............................................................................................+++++
.................+++++
e is 65537 (0x010001)
Can't load /root/.rnd into RNG
139652516762048:error:2406F079:random number generator:RAND_load_file:Cannot open file:../crypto/rand/randfile.c:88:Filename=/root/.rnd
Generating RSA private key, 2048 bit long modulus (2 primes)
.......................................................................................+++++
.......................+++++
e is 65537 (0x010001)
Signature ok
subject=CN = vpa-webhook.kube-system.svc
Getting CA Private Key
Uploading certs to the cluster.
secret/vpa-tls-certs created
Deleting /tmp/vpa-certs.
deployment.apps/vpa-admission-controller created
service/vpa-webhook created

Let's verify the deployment of VPA

kubectl get pods -n kube-system | grep vpa
vpa-admission-controller-747dbdb75b-56vr5   1/1     Running   0          26s
vpa-recommender-796ff4c8b5-6gvtf            1/1     Running   0          26s
vpa-updater-dc56fcb5c-km754                 1/1     Running   0          27s

So, We have deployed metrics server as well as VP autoscaler..!!!!


```

## Running VPA

### Getting resource recommendations from VPA
```
Let's deploy recommended VPA and one deploy for that:
For this we will use two file:
1.  1.vpa-recommend.yaml
2.  1.deployment.yaml

Deploy these two file:
kubectl create -f 1.vpa-recommend.yaml -f 1.deployment.yaml
verticalpodautoscaler.autoscaling.k8s.io/recommended-vpa created
deployment.apps/myapp created

kubectl get vpa,pods
NAME                                                       AGE
verticalpodautoscaler.autoscaling.k8s.io/recommended-vpa   2m11s

NAME                        READY   STATUS    RESTARTS   AGE
pod/myapp-97d6477d6-64nps   1/1     Running   0          2m11s

The output shows recommendations for CPU and memory requests:
kubectl describe vpa recommended-vpa | tail -17
    Type:                  RecommendationProvided
  Recommendation:
    Container Recommendations:
      Container Name:  hello-app
      Lower Bound:
        Cpu:     25m
        Memory:  262144k
      Target:
        Cpu:     25m
        Memory:  262144k
      Uncapped Target:
        Cpu:     25m
        Memory:  262144k
      Upper Bound:
        Cpu:     7321m
        Memory:  96278445172
Events:          <none>

Yes, We are getting the recommendation for mentioned deployments..
Now that you have the recommended CPU and memory requests, you might choose to delete your Deployment, add CPU and memory requests to your Deployment manifest, and start your Deployment again
```
### Updating resource requests automatically
```
We create a Deployment that has two Pods. Each Pod has one container that requests 70 milliCPU and 30 mebibytes of memory. Then you create a VerticalPodAutoscaler that automatically adjusts the CPU and memory requests.

For this we will use two file:
1. 2.deployment.yaml
2. 2.vpa.yaml

Let's deploy it..
kubectl create -f 2.deployment.yaml
deployment.apps/myapp created

kubectl get deploy
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
myapp   2/2     2            2           21s

Our request is for deployments:
kubectl describe deploy myapp
Requests:
      cpu:     70m
      memory:  30Mi
      
let's deploy VPA:
kubectl create -f 2.vpa.yaml
verticalpodautoscaler.autoscaling.k8s.io/my-vpa created

 kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
myapp-5856985dc8-6tv9z   1/1     Running   0          3m43s
myapp-5856985dc8-jwdmz   1/1     Running   0          22s

We can see that one pod recreated with new resouce request.
Notice that the Pod names have changed.
kubectl get pods
NAME                     READY   STATUS        RESTARTS   AGE
myapp-5856985dc8-6tv9z   0/1     Terminating   0          4m30s
myapp-5856985dc8-jwdmz   1/1     Running       0          69s
myapp-5856985dc8-qg9q4   1/1     Running       0          9s

 kubectl describe pods myapp-5856985dc8-jwdmz
  Requests:
      cpu:     25m
      memory:  262144k
This requested is automatic change using VPA:
The updateMode field has a value of Auto, which means that the VerticalPodAutoscaler can update CPU and memory requests during the life of a Pod. That is, the VerticalPodAutoscaler can delete a Pod, adjust the CPU and memory requests, and then start a new Pod.

We can also verigy by seeing pods:
kubectl get pods myapp-5856985dc8-jwdmz -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    vpaObservedContainers: hello-app
    vpaUpdates: 'Pod resources updated by my-vpa: container 0: cpu request, memory
```


## Authors

* **Adil Abdullah Khan**
