generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.96.0"
    }
  }
}
provider "aws" {
  # Configuration options
  region = var.aws_region
}

EOF
}

generate "common_vars" {
  path      = "common-vars.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "dev"
  validation {
    condition     = can(regex("^(dev|stg|sbx|prod)$", var.environment))
    error_message = "The environment variable can only be set to [dev|stg|sbx|prod]."
  }
}

variable "git_repo_url" {
  description = "The URL of the Git repository"
  type        = string
  default     = ""
}

variable "stack_name" {
  description = "The name of the stack that this is part of"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = get_env("TFSTATE_S3_BUCKET", "tfstate-bucket-${get_aws_account_id()}")
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = get_env("TFSTATE_S3_BUCKET_REGION", "us-east-1")
    encrypt        = true
    dynamodb_table = get_env("TFSTATE_DYNAMODB_TABLE", "tfstate-lock-table")

    s3_bucket_tags = {
      "GitRepoURL" = get_env("TF_VAR_git_repo_url", "Unknown")
    }

    dynamodb_table_tags = {
      "GitRepoURL" = get_env("TF_VAR_git_repo_url", "Unknown")
    }
  }
}