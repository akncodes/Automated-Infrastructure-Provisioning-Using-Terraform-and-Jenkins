# Setup Guide

## 1. Prerequisites

Install and configure the following:

- Terraform CLI
- Jenkins
- AWS CLI or equivalent IAM credentials
- Git and GitHub access

## 2. Create the Terraform State Bucket

Create an S3 bucket in AWS before running Terraform init with remote backend enabled.

Example:

```bash
aws s3 mb s3://terraform-state-devops-project --region ap-south-1
```

## 3. Update AWS Credentials

Configure Jenkins credentials or export AWS environment variables locally:

```bash
export AWS_ACCESS_KEY_ID=your_key
export AWS_SECRET_ACCESS_KEY=your_secret
export AWS_DEFAULT_REGION=ap-south-1
```

## 4. Initialize the Terraform Project

```bash
cd terraform
terraform init
```

## 5. Validate the Configuration

```bash
terraform fmt
terraform validate
terraform plan
```

## 6. Run the Jenkins Pipeline

Configure a Jenkins job to use this repository and set the branch to trigger on GitHub webhook events.

The pipeline performs:

- checkout
- init
- fmt check
- validate
- plan
- approval
- apply

## 7. Approval Step

The pipeline pauses before apply. A human must approve the deployment before Terraform modifies AWS resources.

## 8. Post-Deployment Validation

After apply, check:

- EC2 instance launched
- public IP is available
- security group allows required traffic
- Terraform output values are returned correctly
