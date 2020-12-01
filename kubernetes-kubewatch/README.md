## Kubewatch
#### Install helm v3
```
➜  ~ helm version --short
v3.4.1+gc4e7485
```

#### Add Bitnami repo to our helm [ https://github.com/bitnami/charts ]
```
helm repo add bitnami https://charts.bitnami.com/bitnami
➜  ~ helm repo list
NAME    URL
bitnami https://charts.bitnami.com/bitnami
```
##### Update repo
```
➜  ~ helm repo update
```

#### Download bitnami/kubewatch values file and edit acc. to our requirements
```
➜  ~ helm show values bitnami/kubewatch > /tmp/kubewatch-values.yaml

➜  ~ vim /tmp/kubewatch-values.yaml

Edit 
slack:
  enabled: true
  # Slack channel to notify
  channel: "XXXXXXX"
  # Slack bots token. Create using: https://my.slack.com/services/new/bot
  # and invite the bot to your channel using: /join @botname
  token: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  
resourcesToWatch:
  deployment: true
  replicationcontroller: false
  replicaset: true
  daemonset: true
  services: true
  pod: true
  job: false
  persistentvolume: true

rbac:
  create: true

## Specifies whether a ServiceAccount should be created
##
serviceAccount:
  create: true
  ## The name of the ServiceAccount to use.
  ## If not set and create is true, a name is generated using the fullname template
  ##
  name: "kubewatch"
```
#### Now, install chart
```
➜  ~ helm install kubewatch bitnami/kubewatch --values /tmp/kubewatch-values.yaml
```

#### Check the pods for kubewatch
```
➜  ~ kubectl get pods | grep kubewatch
kubewatch-59849596b8-lc7pl                1/1     Running   0          9m9s
```
