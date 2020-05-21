#!/bin/bash
set -ex

yum install wget -y

IFS="|"
EC2_INSTANCE_ID="`/usr/bin/wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`"
TARGET_GROUP_ARNS="${target_group_arns}"

for arn in $TARGET_GROUP_ARNS; do
  aws elbv2 register-targets --target-group-arn $arn --targets Id=$EC2_INSTANCE_ID --region ${region}
done