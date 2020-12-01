#### Kubewatch
##### Install helm v3
```
➜  ~ helm version --short
v3.4.1+gc4e7485
```

###### Add Bitnami repo to our helm [ https://github.com/bitnami/charts ]
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

##### Download bitnami/kubewatch values file and edit acc. to our requirements
```
➜  ~ helm show values bitnami/kubewatch > /tmp/kubewatch-values.yaml

➜  ~ vim /tmp/kubewatch-values.yaml

Edit 
slack:
  enabled: true
  # Slack channel to notify
  channel: "k8s-kubewatch"
  # Slack bots token. Create using: https://my.slack.com/services/new/bot
  # and invite the bot to your channel using: /join @botname
  token: "xoxb-945094518656-1535979740741-UiXVgJdxA04aJJT0m9jKqAAG"
  
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
