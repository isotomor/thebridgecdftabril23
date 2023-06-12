sudo apt update
sudo apt install -y jq
sudo apt install -y postgresql-contrib sysbench
AWSREGION='aws configure get region'

DBENDP=`aws rds describe-db-instances \
    --db-instance-identifier postgresql-database \
    --region $AWSREGION \
    --query 'DBInstances[*].Endpoint.Address' \
    --output text`

# This assumes you named the secret to be secretPostgresqlMasterUser
# There may be more than one secret that has a name like secretPostgresqlMasterUser, 
# so pick the most recently created one
# If error, you should manually set the SECRETARN variable
SECRETARN=`aws secretsmanager list-secrets \
    --query 'sort_by(SecretList[?contains(Name, \`mi-secreto-postgresql-database\`) == \`true\`],&CreatedDate)[-1].ARN' \
    --output text`

CREDS=`aws secretsmanager get-secret-value \
    --secret-id $SECRETARN \
    --region $AWSREGION | jq -r '.SecretString'`

export DBUSER="`echo $CREDS | jq -r '.username'`"
export DBPASS="`echo $CREDS | jq -r '.password'`"
export DBENDP

echo DBENDP: $DBENDP
echo DBUSER: $DBUSER
