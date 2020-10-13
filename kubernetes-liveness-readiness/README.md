### Liveness Probe
##### Liveness Probe restarts the container when the command returns a failure code.
```
1. initialDelaySeconds – time after which Liveness Probe should start polling the endpoint. 
2. periodSeconds – the frequency of polling the endpoint.
3. timeoutSeconds – time after which the timeout will expire. 
4. successThreshold – the minimum number of successful attempts after which the probe will determine the correct operation of the container.
5. failureThreshold – number of failed attempts after which the container will restart.
```
##### There are 3 types of probe:
```
1. Exec
2. HTTP
3. TCP Socket
```
##### Let's discuss HTTP type

###### Deploy the file deploy-liveness.yaml
 ```
 ➤ ➤ ADIL kubernetes-liveness-readiness git:(master)  kubectl create -f deploy-liveness.yaml
deployment.apps/liveness created

➤ ➤ ADIL kubernetes-liveness-readiness git:(master)  kubectl get pods -o wide
NAME                        READY   STATUS    RESTARTS   AGE    IP            NODE        NOMINATED NODE   READINESS GATES
liveness-64b7c78d84-4zsfp   1/1     Running   0          112s   10.244.1.41   kworker01   <none>           <none>
```
##### For this I used Hostpath and the path is /opt/ and mount to /usr/share/nginx/html/
```
Mounts:
      /usr/share/nginx/html/ from nginx-vol (rw)
  Volumes:
   nginx-vol:
    Type:          HostPath (bare host directory volume)
    Path:          /opt/
    HostPathType:  Directory
```
##### Let goto /opt/ on kworker01 node
```
➤ ➤ ADIL kubernetes-liveness-readiness git:(master)  ssh root@kworker01
Last login: Tue Oct 13 07:16:44 2020 from ip-10-127-221-1.us-east-2.compute.internal
[root@kworker01 opt]# ls -ltr /opt/ | grep index
-rw-r--r-- 1 root root    5 Oct 13 07:08 index.html

Here index.html file present that's why liveness probe passing.
let's remove this index.html So, we can test our liveness probe

[root@kworker01 opt]# rm index.html
➤ ➤ ADIL kubernetes-liveness-readiness git:(master)  kubectl describe pods liveness-64b7c78d84-4zsfp | grep "Unhealthy"
  Warning  Unhealthy  3s (x7 over 43s)     kubelet  Liveness probe failed: HTTP probe failed with statuscode: 403
```
##### So here our pods restarted become HTTPS throw 403 error due to not present of index.html
```
➤ ➤ ADIL kubernetes-liveness-readiness git:(master)  kubectl get pod
NAME                        READY   STATUS             RESTARTS   AGE
liveness-64b7c78d84-4zsfp   0/1     CrashLoopBackOff   4          7m46s
```
#### This Keep on restarting the pods.

#### Now, exec into node kworker01 and create a index.html file
```
[root@kworker01 ~]# echo "khan" /opt/index.html
khan /opt/index.html
```
#### Now, pod is in running state
```
➤ ➤ ADIL kubernetes-liveness-readiness git:(master)  kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
liveness-64b7c78d84-4zsfp   1/1     Running   6          9m52s
```
