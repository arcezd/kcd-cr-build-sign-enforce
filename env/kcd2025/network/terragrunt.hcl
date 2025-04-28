include "root" {
  path = find_in_parent_folders()
}

terraform {
  # source = "github.com:foo/infrastructure-modules.git//app?ref=v0.0.1"
  source = "../../../modules/network"
}

inputs = {
  stack_name = "CKD2025"
  subnets = {
    publica = {
      cidr_block = "10.0.254.0/24"
      az         = "us-east-1a",
      public     = true
    },
    publicb = {
      cidr_block = "10.0.253.0/24"
      az         = "us-east-1b"
      public     = true
    },
    privatea = {
      cidr_block = "10.0.0.0/24"
      az         = "us-east-1a"
    },
    privateb = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1b"
    }
  }
}