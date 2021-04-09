#### ============================= FLUX KUBERNETES (Sync)=========================================

1. Installing fluxctl:
```sh
$ sudo snap install fluxctl --classic
```

2. create namespace for flux setup in your k8s cluster:
```sh
$ kubectl create ns flux
```

3. Deploy flux in k8s cluster:
```sh
$ export GHUSER="khann-adill"
$ fluxctl install \
--git-user=${GHUSER} \
--git-email=${GHUSER}@users.noreply.github.com \
--git-url=git@github.com:${GHUSER}/play-with-kubectl \
--git-path=./flux \
--git-branch=master \
--namespace=flux | kubectl apply -f -

where GHUSER--> Github Username
          play-with-kubectl --> repository name
          ./flux --> I want to deploy all manifest inside ./flux dir.
```
4. Check your flux deployment using below command:
```sh
$ kubectl -n flux rollout status deployment/flux
```

5. For checking your flux workload:
```sh
$ export FLUX_FORWARD_NAMESPACE=flux and $ fluxctl list-workloads
else
$ fluxctl list-workloads --k8s-fwd-ns flux
```
6. For manuall syncing:
```sh
$ fluxctl sync 
```
Sync log:
```sh
$ kubectl logs -n flux deploy/flux -f
```
#### ============================ FLUX KUBERNETES (Automating)=====================================
7. Automating using flux:
```sh
$ fluxctl identity
Copy the ssh key and paste in Github Repo Setting > Deploy keys > click on Add deploy key > Add here with write persmissions.
```
8. Add these two annotation in deployment files:
```sh
annotations:
    fluxcd.io/tag.nginx-containers: semver:~1.0
    fluxcd.io/automated: "true"

Where, nginx-containers --> container name used in deployments
```
```yaml
Current Workload status:
WORKLOAD                                       CONTAINER          IMAGE                       	              RELEASE  POLICY
default:deployment/nginx-deploy  nginx-containers  mak1806/custom-nginx:1.0.2 	 ready
```

Image version is: 1.0.2

```json
Let's push newer version in docker hub.
$ docker tag mak1806/custom-nginx:v1.0 mak1806/custom-nginx:1.0.3
$ docker push mak1806/custom-nginx:1.0.3
```
Using log we can check the change in version and automation:
```log
ts=2021-04-09T12:11:24.083307223Z caller=images.go:111 component=sync-loop workload=default:deployment/nginx-deploy container=nginx-containers repo=mak1806/custom-nginx pattern=semver:~1.0 current=mak1806/custom-nginx:1.0.1 info="added update to automation run" new=mak1806/custom-nginx:1.0.3 reason="latest 1.0.3 (2020-09-01 11:07:13.810690242 +0000 UTC) > current 1.0.1 (2020-09-01 11:07:13.810690242 +0000 UTC)"
ts=2021-04-09T12:11:24.083399563Z caller=loop.go:142 component=sync-loop jobID=5b7b96f6-7909-1bc1-3155-d99f330026a3 state=in-progress
ts=2021-04-09T12:11:26.476377972Z caller=releaser.go:59 component=sync-loop jobID=5b7b96f6-7909-1bc1-3155-d99f330026a3 type=release updates=1
ts=2021-04-09T12:11:30.58093894Z caller=daemon.go:292 component=sync-loop jobID=5b7b96f6-7909-1bc1-3155-d99f330026a3 revision=51ca1b4012490b0a15881bbe7218692c1cf84e9e
ts=2021-04-09T12:11:30.581089058Z caller=daemon.go:701 component=daemon event="Commit: 51ca1b4, default:deployment/nginx-deploy" logupstream=false
ts=2021-04-09T12:11:30.582412901Z caller=loop.go:154 component=sync-loop jobID=5b7b96f6-7909-1bc1-3155-d99f330026a3 state=done success=true
ts=2021-04-09T12:11:31.893782632Z caller=loop.go:134 component=sync-loop event=refreshed url=ssh://git@github.com/khann-adill/play-with-kubectl branch=master HEAD=51ca1b4012490b0a15881bbe7218692c1cf84e9e
```
```sh
$ fluxctl list-workloads
WORKLOAD                         CONTAINER         IMAGE                       RELEASE  POLICY
default:deployment/nginx-deploy  nginx-containers  mak1806/custom-nginx:1.0.3  ready    automated
```
