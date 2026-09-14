terraform {
  backend "s3" {
    bucket = "terraform-state-devops-project"
    key    = "terraform/jenkins-iac/terraform.tfstate"
    region = "ap-south-1"
  }
}
