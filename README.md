# Description

Deploy your NestJs application to AWS using Lambda, Api Gateway and CloudWatch.

# How to use

Prepare your application for production using the suggested commands below:

```shell
npm i --production
npm run build
mv node_modules dist
```

Run Terraform to deploy your application to AWS:

```shell
terraform plan 
terraform apply --auto-approve
terraform destroy --auto-approve
```

# How to test

Pay attention to the Lambda URL that Terraform will show if everything went well and read [outputs.tf](ci/outputs.tf) for more information about other resources created.

# 🚨 Bear in mind

These services will probably be charged for by AWS.

    * Lambda
    * S3
    * CloudWatch
    * Api Gateway

Remember to run `terraform destroy --auto-approve` after your studies.
