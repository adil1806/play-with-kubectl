

First create service account, role, rolebinding, pod with that service account.
then, exec into pod using coomand

kubectl exec -it nginx -- bash
then check kubernetes service account secret:
ls -ltr /var/run/secrets/kubernetes.io/serviceaccount

then create a variable that will be used in curl command

CA_CERT=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)

Then run
curl --cacert $CA_CERT -H "Authorization: Bearer $TOKEN" "https://kubernetes/api/v1/namespaces/$NAMESPACE/services/"

As, we will able to see only pods via API as we define pods to be view using this role.
