### DEMO
1. Create a policy for your node instance profile that allows the Amazon EBS CSI Driver to make calls to AWS APIs on your behalf.for your node instance profile that allows the Amazon EBS CSI Driver to make calls to AWS APIs on your behalf.

aws iam create-policy --policy-name Amazon_EBS_CSI_Driver \
    --policy-document file://example-iam-policy.json

2. Getting node rolearm name:
kubectl -n kube-system describe configmap aws-auth | grep rolearn | cut -d '/' -f2

3. Attahc policy to that nodegroup
aws iam attach-role-policy \
--policy-arn <XYZ>
--role-name <Output of snd. step>
  
4. Now, create a StorageClass
kubectl create -f storageclass.yaml

5. Now, create a claim:
kubectl create -f claim.yaml
Here, You see by creating a claim kubernetes provisioned a persistent volume of type AWS EBS.
