#### ==================== FLUX KUBERNETES (Sync)=============================================

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
#### ==================== FLUX KUBERNETES (Automating)=============================================
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
