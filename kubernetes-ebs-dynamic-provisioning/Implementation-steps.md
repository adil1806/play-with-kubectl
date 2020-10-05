# STEP for AWS EBS Dynamic Provisioning
# 1. Create a policy for your node instance profile that allows the Amazon EBS CSI Driver to make calls to AWS APIs on your behalf.for your node instance profile that allows the Amazon EBS CSI Driver to make calls to AWS APIs on your behalf:

# cd to play-with-kubectl/kubernetes-ebs-dynamic-provisioning/

aws iam create-policy --policy-name Amazon_EBS_CSI_Driver \
--policy-document file://example-iam-policy.json

# 2. Run the below command for getting node rolearm name:
kubectl -n kube-system describe configmap aws-auth | grep rolearn | cut -d '/' -f2

# 3. Attach policy to that nodegroup:
aws iam attach-role-policy \
--policy-arn policy-arn-number \
--role-name output from step-2

# 5. Deploy the Amazon EBS CSI Driver
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"

  
# 5. Now, create a StorageClass
kubectl create -f storageclass.yaml

# 6. Now, create a claim:
kubectl create -f claim.yaml
# Here, You see by creating a claim kubernetes provisioned a persistent volume of type AWS EBS.


# Refer AWS Doc: https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html
