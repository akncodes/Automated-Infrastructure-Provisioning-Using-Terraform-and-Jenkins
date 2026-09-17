# Automated Infrastructure Provisioning Using Terraform and Jenkins

A DevOps project that automates AWS infrastructure provisioning with Terraform and orchestrates the deployment workflow through Jenkins. The goal is to make cloud infrastructure repeatable, reviewable, and safe to deploy using version-controlled IaC and a controlled release process.

## Overview

This project demonstrates a practical CI/CD pattern for infrastructure automation:

- GitHub stores the infrastructure definition and pipeline configuration
- Jenkins triggers automated validation and deployment workflows
- Terraform provisions AWS resources as code
- Manual approval is enforced before applying production changes
- Remote state is managed in S3 for consistency and team-friendly workflows

## Architecture

```text
Developer / GitHub
        |
        v
   Jenkins Pipeline
        |
        +--> Terraform fmt
        +--> Terraform init
        +--> Terraform validate
        +--> Terraform plan
        +--> Manual approval
        +--> Terraform apply
        |
        v
   AWS Cloud
   - VPC
   - Public subnet
   - Internet gateway
   - Route table
   - Security group
   - EC2 instance
```

## Why this project matters

Infrastructure automation reduces manual errors, speeds up deployments, and creates a clean audit trail for infrastructure changes. This project is designed to show how AWS resources can be defined in code and deployed through a controlled Jenkins pipeline rather than through ad hoc manual steps.

## Features

- Infrastructure as Code using Terraform
- AWS resource provisioning for a basic, production-style environment
- Jenkins pipeline for build validation and deployment automation
- Manual approval gate before resource changes are applied
- S3 backend for remote Terraform state storage
- Clean separation between configuration, documentation, and deployment setup

## Tech Stack

- Terraform
- AWS EC2 / VPC / Networking
- Jenkins
- GitHub
- AWS IAM and S3

## Repository Structure

```text
Devops/
├── .gitignore
├── Jenkinsfile
├── README.md
├── aws/
│   ├── deployment-ready-guide.md
│   ├── iam-policy.json
│   ├── jenkins-aws-credentials.md
│   └── s3-backend-setup.md
├── docs/
│   ├── README.md
│   ├── aws-setup.md
│   └── setup.md
├── github/
│   └── webhook-setup.md
├── terraform/
│   ├── backend.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tfvars
│   └── variables.tf
└── LICENSE
```

## Deployment Workflow

1. Push code to the GitHub repository
2. Jenkins automatically starts the pipeline
3. Terraform initializes the working directory
4. Formatting and validation checks run
5. A plan is generated for review
6. A human approves the apply step
7. Terraform creates the AWS infrastructure

## Prerequisites

Before running this project in AWS, make sure you have:

- An active AWS account
- IAM permissions to create VPC, EC2, IAM, and S3 resources
- Terraform installed locally
- Jenkins installed or available in a controlled environment
- GitHub repository access configured for CI/CD
- An S3 bucket for Terraform remote state

## Example Terraform Commands

```bash
cd terraform
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

## Jenkins Pipeline Stages

The Jenkinsfile includes the following stages:

- Checkout
- Terraform Init
- Terraform Format Check
- Terraform Validate
- Terraform Plan
- Manual Approval
- Terraform Apply

## Project Notes

This repository is structured to be easy to understand and extend. The AWS resources are intentionally simple but representative of a real-world IaC deployment pattern. The S3 backend configuration and AWS IAM guidance are included to support deployment readiness in a real environment.

## Documentation

For setup steps, AWS configuration guidance, Jenkins credential handling, and GitHub webhook integration, see:

- [docs/README.md](docs/README.md)
- [docs/setup.md](docs/setup.md)
- [aws/iam-policy.json](aws/iam-policy.json)
- [aws/s3-backend-setup.md](aws/s3-backend-setup.md)
- [github/webhook-setup.md](github/webhook-setup.md)

## Status

This project is ready as a GitHub-facing DevOps portfolio example demonstrating infrastructure automation, pipeline orchestration, and cloud provisioning with Terraform and Jenkins.
