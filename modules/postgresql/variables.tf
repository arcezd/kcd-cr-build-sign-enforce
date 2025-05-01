variable "vpc_id" {
  description = "The VPC ID where the DB instance will be created"
  type        = string
}

variable "identifier" {
  description = "The AWS DB instance identifier"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the DB instance"
  type        = string
  default     = "db.t4g.small"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 5
}

variable "backup_retention_period" {
  description = "The number of days to retain backups. Default is 0 (disabled)"
  type        = number
  default     = 0
}

variable "db_username" {
  description = "The username for the master DB user"
  type        = string
  default     = "demouser"
}

variable "db_password" {
  description = "The password for the master DB user"
  type        = string
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = 5432
}

# variable "final_snapshot_identifier_prefix" {
#   description = "The prefix for the final snapshot identifier. by default it's bkp_<identifier>"
#   type        = string
#   default     = "bkp_"
# }

variable "db_engine" {
  description = "The database version to use"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The database engine version to use"
  type        = string
  default     = "12.22"
}

variable "db_family" {
  description = "The db family of the DB instance"
  type        = string
  default     = "postgres12"
}

variable "subnet_ids" {
  description = "The list of subnet IDs for the DB instance"
  type        = list(string)
}