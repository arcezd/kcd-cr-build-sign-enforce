output "db_engine_endpoint" {
  description = "The endpoint of the DB instance"
  value       = module.db.db_instance_endpoint
}

output "db_instance_port" {
  description = "The db instance port"
  value       = module.db.db_instance_username
}

output "db_instance_username" {
  description = "The username for the master DB user"
  value       = module.db.db_instance_username
}
