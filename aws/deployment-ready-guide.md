# Deployment-Ready AWS and Jenkins Configuration

## 1. AWS S3 backend

Create the S3 bucket and optional DynamoDB table before the first Terraform run.

```bash
aws s3 mb s3://terraform-state-devops-project --region ap-south-1
aws s3api put-bucket-versioning \
  --bucket terraform-state-devops-project \
  --versioning-configuration Status=Enabled
aws s3api put-bucket-encryption \
  --bucket terraform-state-devops-project \
  --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --region ap-south-1
```

## 2. AWS IAM policy

The IAM policy file at [aws/iam-policy.json](aws/iam-policy.json) is aligned with the Terraform resources used by the repository:

- VPC
- subnet
- internet gateway
- route table
- security group
- EC2 instance
- S3 backend access
- DynamoDB lock table access

Use this policy attached to the Jenkins execution user or role.

## 3. Jenkins credentials flow

In Jenkins:

1. Go to Manage Jenkins > Credentials > System > Global credentials
2. Add a new AWS credential entry with ID: `aws-terraform-creds`
3. Store:
   - AWS_ACCESS_KEY_ID
   - AWS_SECRET_ACCESS_KEY
4. The pipeline uses `withCredentials` and binds them to the environment before every Terraform command.

This matches the repository pipeline and avoids hardcoding secrets.

## 4. GitHub webhook

Configure the repository webhook to trigger Jenkins on push events:

- URL: `http://<jenkins-host>/github-webhook/`
- Content type: `application/json`
- Event: `Push`

## 5. Jenkins pipeline behavior

The pipeline executes:

1. Checkout
2. Terraform Init
3. Terraform Format Check
4. Terraform Validate
5. Terraform Plan
6. Manual approval
7. Terraform Apply

This creates a controlled CI/CD workflow consistent with the project documentation.

## 6. Final deployment checklist

- AWS S3 state bucket created
- AWS DynamoDB lock table created
- Jenkins AWS credential exists
- GitHub webhook configured
- Jenkins job pointed to this repository
- AWS IAM policy attached
- pipeline is approved before apply

## 7. Notes

This configuration is intentionally conservative and appropriate for learning and small-scale AWS automation. For production, consider:

- separate roles for dev and prod
- stricter IAM boundaries
- state encryption and bucket policies
- environment-specific tfvars
- security scanning in the pipeline
