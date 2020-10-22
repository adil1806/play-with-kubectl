### Started With HELM & Tiller

#### Helm Setup
```
Current k8s cluster version

$ kubectl version --short
Client Version: v1.19.3
Server Version: v1.19.3

$ wget https://get.helm.sh/helm-v2.17.0-rc.1-linux-amd64.tar.gz

$ tar xvf helm-v2.17.0-rc.1-linux-amd64.tar.gz

$ cd linux-amd64

$ mv helm /usr/local/bin

$ which helm

$ helm version --short
Client: v2.17.0-rc.1+ga690bad
Error: could not find tiller --> Due to tiller has'nt installed
```
#### Tiller Setup
##### Service Account for tiller componenet
```
$ kubectl -n kube-system create serviceaccount tiller
serviceaccount/tiller created

$ kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
clusterrolebinding.rbac.authorization.k8s.io/tiller created

$ helm init --service-account tiller

$ kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS    RESTARTS   AGE
kube-system   tiller-deploy-5dc7b69d66-cslr6            1/1     Running   0          15s

$ helm version --short
Client: v2.17.0-rc.1+ga690bad
Server: v2.17.0-rc.1+ga690bad
```
