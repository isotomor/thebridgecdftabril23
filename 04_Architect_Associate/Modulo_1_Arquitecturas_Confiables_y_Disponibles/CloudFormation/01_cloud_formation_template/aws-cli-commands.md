# Ejecución de un template de Cloud Formation

Aquí se van a ver una serie de pasos para la ejecución de un template de cloud formation. 

````bash
aws acm list-certificates
aws cloudformation validate-template --template-body file://app-stack1.json
aws cloudformation validate-template --template-body file://app-stack2.json
aws cloudformation validate-template --template-body file://network-stack1ab.json
aws cloudformation validate-template --template-body file://network-stack2bc.json
aws s3 cp network-stack.json s3://bucket-cloud-formation-template # Tu bucket de S3
aws cloudformation deploy --template-file "app-stack1.json" --stack-name "app-stack1"
aws cloudformation deploy --template-file "app-stack2.json" --stack-name "app-stack2"
aws cloudformation describe-stacks
aws cloudformation describe-stacks --stack-name "app-stack1"
aws cloudformation describe-stacks --stack-name "app-stack2"
aws autoscaling describe-auto-scaling-instances

aws cloudformation delete-stack --stack-name "app-stack1"
aws cloudformation delete-stack --stack-name "app-stack2"
aws cloudformation describe-stacks
````

