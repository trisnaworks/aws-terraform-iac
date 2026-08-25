# Terraform AWS Infrastructure: VPC, EC2, and RDS

This project provisions a complete AWS environment using Terraform, including a custom VPC, a public facing web server, and a private MySQL database. Infrastructure is fully defined as code, uses a remote backend for state management, and follows secure defaults rather than open ones.

## What This Project Does

- Builds a custom VPC with public subnets across two availability zones
- Deploys an EC2 instance running a simple web app, reachable over HTTP
- Deploys an RDS MySQL database that is not publicly reachable
- Uses security groups so only the web server can talk to the database
- Stores Terraform state remotely in S3 with DynamoDB state locking
- Splits infrastructure into reusable modules: network, compute, and database
