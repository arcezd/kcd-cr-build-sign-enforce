variable "identifier" {
  description = "The identifier for the cache cluster."
  type        = string
}

variable "engine" {
  description = "The cache engine to use"
  type        = string
  default     = "redis"
}

variable "node_type" {
  description = "The instance type to use for the cache nodes."
  type        = string
  default     = "cache.t3.small"
}

variable "num_cache_nodes" {
  description = "The number of cache nodes in the cluster."
  type        = number
  default     = 1
}

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with the cache cluster."
  type        = string
  default     = "default.redis4.0"
}

variable "engine_version" {
  description = "The version of the cache engine to use."
  type        = string
  default     = "4.0.10"
} 

variable "port" {
  description = "The port number on which the cache engine is listening."
  type        = number
  default     = 6379
}

variable "vpc_id" {
  description = "The ID of the VPC in which to create the cache cluster."
  type        = string
}

variable "subnet_ids" {
  description = "The list of subnet IDs for the cache cluster."
  type        = list(string)
}