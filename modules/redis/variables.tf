variable "port" {
  description = "The port number on which the cache engine is listening."
  type        = number
  default     = 6379
}

variable "engine_version" {
  description = "The version of the cache engine to use."
  type        = string
  default     = "3.2.10"
} 