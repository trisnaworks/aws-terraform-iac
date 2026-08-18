output "web_instance_public_ip" {
  description = "Public IP address of the web server"
  value       = module.compute.instance_public_ip
}

output "db_endpoint" {
  description = "Connection endpoint for the RDS database"
  value       = module.database.db_endpoint
}