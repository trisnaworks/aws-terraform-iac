variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "my_ip" {
  description = "My IP address in CIDR format, for SSH access (e.g. 203.0.113.5/32)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (region-specific)"
  type        = string
  default     = "ami-0759dd6cc057c789f"
}