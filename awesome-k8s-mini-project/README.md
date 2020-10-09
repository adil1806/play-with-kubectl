# K8s Mini Project Demo

Deploying a maven based application on k8s cluster

## Getting Started
```
Create a Hello World app.
Package the app into a container image using Docker Build.
Create a cluster.
Deploy the container image to your cluster.
```
### Prerequisites

Setup for k8s Cluster and Maven JDK.

### Installing
For building the application maven is required.
```
clone the repo play-with-kubectl
Go to directory play-with-kubectl/awesome-k8s-mini-project/
Build the image: docker build -t myapp:v1 .

Successfully built 1ee5c05c008b
Successfully tagged myapp:v2

Then push this to docker hub.
for that we have to tag with hub username
docker tag myapp:v2 mak1806/myapp:v2
Now, docker push mak1806/myapp:v2

docker push mak1806/myapp:v2
The push refers to repository [docker.io/mak1806/myapp]
cdce94143532: Pushed
ba65aa7d47d1: Layer already exists
9281022c8a4b: Layer already exists
0dc5be0689ba: Layer already exists
bcf2f368fe23: Layer already exists
v2: digest: sha256:730759ab******************3ab2ee8d0cd3f591 size: 1371


Here..!! We have created your image and pushed it..
Now, it's time to deployment our images to k8s
On the project directory there was a deployment.yaml file which deploy pod with 1 replicas and having deployment name myapp

 kubectl apply -f deployment.yaml
 deployment.apps/myapp created
 kubectl get deploy
NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
myapp                1/1     1            1           5m13s

kubectl get rs
NAME                           DESIRED   CURRENT   READY   AGE
myapp-97d6477d6                1         1         1       5m41s

 kubectl get pods
NAME                                 READY   STATUS    RESTARTS   AGE
myapp-97d6477d6-rgcxx                1/1     Running   0          5m57s

Our, deployment is done.. To accessing this we need to create service of NodePort/LoadBalancer type.

On the project directory there was a service file which deploy service of NodePort which can access using any node IP's and Nodeport
Let's create a service.
kubectl create -f service.yaml
service/myapp-svc created

kubectl get svc
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
myapp-svc    NodePort    10.99.112.216    <none>        80:32323/TCP   40s

Endpoint for this service is:
kubectl get endpoints myapp-svc
NAME        ENDPOINTS                           AGE
myapp-svc   10.244.3.14:8080                    73s

Endpoint is pointing to Internal IP of pod.

 kubectl get po -o wide
NAME                                 READY   STATUS    RESTARTS   AGE    IP            NODE        NOMINATED NODE   READINESS GATES
myapp-97d6477d6-rgcxx                1/1     Running   0          15m    **10.244.3.14**   kworker03   <none>           <none>

Now, let's access your application
curl 3.15.174.220:30364
Hello Kubernetes!#
```

## Contributing

Please read(https://github.com/adil1806/play-with-kubectl.git) for details on K8s.


## Authors

* **Adil Abdullah Khan**

