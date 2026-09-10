# Terraform + Jenkins Infrastructure Automation Project

This repository contains a simple Infrastructure as Code project that provisions AWS infrastructure using Terraform and automates the workflow through Jenkins.

## Project Goal

The goal is to automate the creation of AWS infrastructure in a repeatable, version-controlled, and review-based way using:

- Terraform for infrastructure definition
- Jenkins for CI/CD orchestration
- GitHub for source control
- AWS for the cloud environment

## Architecture

```text
Developer -> GitHub -> Jenkins -> Terraform -> AWS
```

The workflow includes:

1. Code push to GitHub
2. Jenkins webhook triggers a build
3. Terraform init, format check, validate, and plan
4. Manual approval before apply
5. Infrastructure deployment to AWS

## Repository Structure

```text
Devops/
├── .gitignore
├── Jenkinsfile
├── README.md
├── terraform/
│   ├── backend.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tfvars
│   └── variables.tf
└── docs/
    ├── README.md
    └── setup.md
```

## Included Resources

The Terraform configuration provisions:

- VPC
- Public subnet
- Internet gateway
- Route table
- Security group
- EC2 instance

## Jenkins Pipeline Stages

The Jenkinsfile contains these stages:

- Checkout
- Terraform Init
- Terraform Format Check
- Terraform Validate
- Terraform Plan
- Approval
- Terraform Apply

## Prerequisites

Before running the project, ensure the following are configured:

- AWS account with IAM access
- Terraform installed
- Jenkins installed and configured
- GitHub repository connected to Jenkins
- S3 bucket for remote Terraform state

## Terraform Commands

```bash
cd terraform
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

## Important Note

The backend configuration uses an S3 bucket name that must exist before initialization in a real AWS environment.

## Next Steps

- configure AWS credentials in Jenkins
- create the remote state S3 bucket
- configure GitHub webhook
- run the pipeline and approve the apply stage

## Documentation

See [docs/README.md](docs/README.md) for setup and usage notes.
