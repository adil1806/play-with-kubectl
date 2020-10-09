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
myapp-97d6477d6-rgcxx                1/1     Running   0          15m    *10.244.3.14*   kworker03   <none>           <none>
```



End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
