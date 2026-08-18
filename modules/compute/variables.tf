variable "vpc_id" {
  description = "The VPC ID where the web server will be launched"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the web server will be launched"
  type        = string
}

variable "my_ip" {
  description = "My IP address in CIDR format, allowed to SSH into the instance (e.g. 203.0.113.5/32)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}