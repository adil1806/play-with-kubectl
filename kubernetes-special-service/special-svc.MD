#### Kubernetes Access Service located in another namespace
##### Introduction
```
Different namespace may required to access the service located in another namespace and kubernetes allow this by using ExternalName concept.
An ExternalName Service is a special case of Service that does not have selectors and uses DNS names instead.
To demonstrate the ExternalName lets assume we have a service of nginx which is running on defualt namespace.

➜  play-with-kubectl git:(master) ✗ k get svc
NAME              TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
nginx             ClusterIP   10.96.94.3     <none>        80/TCP         9m30s

➜  play-with-kubectl git:(master) ✗ k describe svc nginx
Name:              nginx
Namespace:         default
Labels:            app=nginx
Annotations:       <none>
Selector:          app=nginx
Type:              ClusterIP
IP Families:       <none>
IP:                10.96.94.3
IPs:               10.96.94.3
Port:              <unset>  80/TCP
TargetPort:        80/TCP
Endpoints:         10.244.32.16:80
Session Affinity:  None
Events:            <none>
```
##### Access within same namespace
```
To test, using other pod located in the default namespace is accessing this service using DNS name mysql.
➜  play-with-kubectl git:(master) ✗ k exec -it wordpress-7d97b97c5f-mtkrc -- sh
# curl -Is nginx
curl -Is nginx
HTTP/1.1 200 OK
```

##### Can't access service nginx located in default namespace in demo namespace
```
In another namspace
➜  play-with-kubectl git:(master) ✗ k exec -it -n demo demo-997c454df-88sx7 -- bash
root@demo-997c454df-88sx7:/# curl -Is nginx
```

##### To Access the nginx service in the default namespace we need to build a service with type ExternalName as shown below. The externalName must point to the namespace which we are trying to access on that namespace.
```
nginx.default.svc.cluster.local

kind: Service
apiVersion: v1
metadata:
  name: mysql
  namespace: demo
spec:
  type: ExternalName
  externalName: nginx.default.svc.cluster.local
  ports:
  - port: 80
  
➜  play-with-kubectl git:(master) ✗ k get svc -n demo
NAME            TYPE           CLUSTER-IP   EXTERNAL-IP                       PORT(S)   AGE
nginx-default   ExternalName   <none>       nginx.default.svc.cluster.local   80/TCP    3s

The ExternalName is configured properly, now different pod should be access the service nginx which is located in another namespace.

➜  play-with-kubectl git:(master) ✗ k exec -it -n demo demo-997c454df-88sx7 -- bash
root@demo-997c454df-88sx7:/# curl -Is nginx-default
HTTP/1.1 200 OK
```
