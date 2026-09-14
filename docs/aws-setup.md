# AWS Setup Notes

## Required AWS Services

The Terraform project uses the following AWS resources:

- VPC
- Subnet
- Internet Gateway
- Route table
- Security group
- EC2 instance

## IAM Requirements

The AWS credentials used by Jenkins need permissions for at least:

- EC2
- VPC
- IAM
- S3

## Recommended Security Pattern

Use an IAM role or user with least-privilege permissions instead of embedding credentials in code.

## Remote State Storage

A remote S3 backend is recommended for storing Terraform state. This prevents local state drift and makes the Jenkins pipeline more reliable in shared environments.
