# AWS Backend Setup

## 1. Create the S3 bucket

Run the following command in AWS CLI:

```bash
aws s3 mb s3://terraform-state-devops-project --region ap-south-1
```

If the bucket already exists, skip this step.

## 2. Enable versioning (recommended)

```bash
aws s3api put-bucket-versioning \
  --bucket terraform-state-devops-project \
  --versioning-configuration Status=Enabled
```

## 3. Enable server-side encryption (recommended)

```bash
aws s3api put-bucket-encryption \
  --bucket terraform-state-devops-project \
  --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
```

## 4. Create a DynamoDB lock table (optional but recommended)

```bash
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --region ap-south-1
```

## 5. Update the backend config

If you enable DynamoDB locking, add this to the backend configuration:

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-devops-project"
    key            = "terraform/jenkins-iac/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```
