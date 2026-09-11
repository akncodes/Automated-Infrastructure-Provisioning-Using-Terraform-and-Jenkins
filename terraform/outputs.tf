output "vpc_id" {
  description = "The ID of the generated VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet."
  value       = aws_subnet.public.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance."
  value       = aws_instance.web.public_ip
}

output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.web.id
}
