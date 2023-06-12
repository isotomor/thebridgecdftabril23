AWSREGION=`aws configure get region`

# Obtiene el DBSubnetGroup, VPCSecurityGroupID, KMSKeyID y el ARN del Enhanced Monitoring Role

RDSSTACK=$(aws cloudformation describe-stacks \
  --query 'Stacks[*].StackName' | grep RDSStack | tr -d \",)

DBSUBNETGRP=$(aws cloudformation describe-stack-resources \
  --stack-name $RDSSTACK \
  --region $AWSREGION \
  --query 'StackResources[?LogicalResourceId==`DBSubnetGroup`].PhysicalResourceId' \
  --output text)

DBSECGRP=$(aws cloudformation describe-stack-resources \
  --stack-name $RDSSTACK \
  --region $AWSREGION \
  --query 'StackResources[?LogicalResourceId==`dbSecGroupCluster`].PhysicalResourceId' \
  --output text)

EMROLE=$(aws cloudformation describe-stack-resources \
  --stack-name $RDSSTACK \
  --region $AWSREGION \
  --query 'StackResources[?LogicalResourceId==`roleEnhancedMonitoring`].PhysicalResourceId' \
  --output text)

EMROLEARN=$(aws iam get-role \
  --role-name $EMROLE \
  --region $AWSREGION \
  --query 'Role.Arn' \
  --output text)

RDSKMSKEY=$(aws kms list-aliases \
  --region $AWSREGION \
  --query 'Aliases[?AliasName==`alias/aws/rds`].TargetKeyId' \
  --output text)

# Crea la instancia de BD

aws rds create-db-instance \
	--db-instance-identifier rds-pg-labs \
	--db-name pglab \
	--engine postgres \
	--engine-version 13.3 \
	--master-username masteruser \
	--master-user-password $MASTER_USER_PASSWORD \
	--db-instance-class db.t3.medium \
	--storage-type io1 \
	--iops 1000 \
	--allocated-storage 100 \
	--no-multi-az \
	--db-subnet-group $DBSUBNETGRP \
	--vpc-security-group-ids $DBSECGRP \
	--no-publicly-accessible \
	--enable-iam-database-authentication \
	--backup-retention-period 1 \
	--copy-tags-to-snapshot \
	--auto-minor-version-upgrade \
	--storage-encrypted \
	--kms-key-id $RDSKMSKEY \
	--monitoring-interval 1 \
	--monitoring-role-arn $EMROLEARN \
	--enable-performance-insights \
	--performance-insights-kms-key-id $RDSKMSKEY \
	--performance-insights-retention-period 7 \
	--enable-cloudwatch-logs-exports '["postgresql","upgrade"]' \
	--region $AWSREGION

