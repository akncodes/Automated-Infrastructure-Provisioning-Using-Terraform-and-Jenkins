variable "aws_region" {
  description = "AWS region for Terraform resources."
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type for the application host."
  type        = string
  default     = "t2.micro"
}
