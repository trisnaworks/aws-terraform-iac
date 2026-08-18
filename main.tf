########################################
# Terraform & Backend Configuration
########################################
terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-trisna"
    key            = "terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

########################################
# AWS Provider
########################################
provider "aws" {
  region = "ap-southeast-2"
}

########################################
# Network Module
########################################
module "network" {
  source = "./modules/network"

  vpc_cidr             = "10.0.0.0/16"
  public_subnet_1_cidr = "10.0.1.0/24"
  public_subnet_2_cidr = "10.0.2.0/24"
  az_1                 = "ap-southeast-2a"
  az_2                 = "ap-southeast-2b"
}

########################################
# Compute Module
########################################
module "compute" {
  source = "./modules/compute"

  vpc_id    = module.network.vpc_id
  subnet_id = module.network.public_subnet_ids[0]
  my_ip     = var.my_ip
  ami_id    = var.ami_id
}

########################################
# Database Security Group
########################################
resource "aws_security_group" "db_sg" {
  name   = "db-sg"
  vpc_id = module.network.vpc_id

  ingress {
    description     = "Allow MySQL from the web server only"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.compute.security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

########################################
# Database Module
########################################
module "database" {
  source = "./modules/database"

  subnet_ids              = module.network.public_subnet_ids
  db_name                  = var.db_name
  db_username              = var.db_username
  db_password              = var.db_password
  db_security_group_ids   = [aws_security_group.db_sg.id]
}