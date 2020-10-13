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
 ```
 Deploy the file deploy-liveness.yaml
 
 ➤ ➤ ADIL kubernetes-liveness-readiness git:(master)  kubectl create -f deploy-liveness.yaml
deployment.apps/liveness created

➤ ➤ ADIL kubernetes-liveness-readiness git:(master)  kubectl get pods -o wide
NAME                        READY   STATUS    RESTARTS   AGE    IP            NODE        NOMINATED NODE   READINESS GATES
liveness-64b7c78d84-4zsfp   1/1     Running   0          112s   10.244.1.41   kworker01   <none>           <none>
```
##### For this I used Hostpath and the path is /opt/ and mount to /usr/share/nging/html/

Mounts:
      /usr/share/nginx/html/ from nginx-vol (rw)
  Volumes:
   nginx-vol:
    Type:          HostPath (bare host directory volume)
    Path:          /opt/
    HostPathType:  Directory
