variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets" {
  description = "Map of subnets to create"
  type        = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool, false)
  }))
}