# Jenkins AWS Credentials Setup

## 1. Create IAM user or role

Create an AWS IAM user or role with sufficient permissions to manage the Terraform resources.

## 2. Add AWS credentials in Jenkins

In Jenkins:

- Go to Manage Jenkins
- Select Credentials
- Add a new secret text or AWS credential entry
- Store:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
  - AWS_DEFAULT_REGION=ap-south-1

## 3. Configure credentials in the pipeline

Use the credentials in the Jenkins pipeline with either:

```groovy
withCredentials([
    [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']
]) {
    sh 'terraform init'
    sh 'terraform plan'
    sh 'terraform apply -auto-approve'
}
```

## 4. Recommended security practice

Use an IAM role or restricted user instead of hardcoding keys in scripts or configuration files.
