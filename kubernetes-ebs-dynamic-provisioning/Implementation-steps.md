### DEMO
#1. Create a policy for your node instance profile that allows the Amazon EBS CSI Driver to make calls to AWS APIs on your behalf.for your node instance profile that allows the #Amazon EBS CSI Driver to make calls to AWS APIs on your behalf.

#cat << EOF > example-iam-policy.json
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Action": [
#        "ec2:AttachVolume",
# "ec2:CreateSnapshot",
#      "ec2:CreateTags",
#        "ec2:CreateVolume",
#        "ec2:DeleteSnapshot",
#        "ec2:DeleteTags",
#        "ec2:DeleteVolume",
#        "ec2:DescribeInstances",
#        "ec2:DescribeSnapshots",
#        "ec2:DescribeTags",
#        "ec2:DescribeVolumes",
#        "ec2:DetachVolume"
#      ],
#      "Resource": "*"
#    }
#  ]
#}
#EOF
