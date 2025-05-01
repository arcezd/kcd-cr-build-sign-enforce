output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# filter subnets with db_subnet = true from the subnets map

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for k, v in var.subnets : aws_subnet.main[k].id if v.public == true]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for k, v in var.subnets : aws_subnet.main[k].id if v.public == false && v.db_subnet == false]
}

output "db_subnet_ids" {
  description = "List of private subnet IDs for DBs resources"
  value       = [for k, v in var.subnets : aws_subnet.main[k].id if v.db_subnet == true]
}