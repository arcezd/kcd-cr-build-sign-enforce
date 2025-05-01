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
      cidr_block      = "10.0.254.0/24"
      az              = "us-east-1a",
      public          = true,
      additional_tags = {
        "kubernetes.io/role/elb" = "1"
      }
    },
    publicb = {
      cidr_block      = "10.0.253.0/24"
      az              = "us-east-1b"
      public          = true,
      additional_tags = {
        "kubernetes.io/role/elb" = "1"
      }
    },
    privatea = {
      cidr_block      = "10.0.0.0/20"
      az              = "us-east-1a"
      additional_tags = {
        "kubernetes.io/role/internal-elb" = "1"
        "karpenter.sh/discovery" = "k8s-arce-kcd-01"
        "kubernetes.io/role/cni" = "1"
      }
    },
    privateb = {
      cidr_block      = "10.0.16.0/20"
      az              = "us-east-1b",
      additional_tags = {
        "kubernetes.io/role/internal-elb" = "1"
        "karpenter.sh/discovery" = "k8s-arce-kcd-01"
        "kubernetes.io/role/cni" = "1"
      }
    },
    privatec = {
      cidr_block      = "10.0.32.0/20"
      az              = "us-east-1c",
      additional_tags = {
        "kubernetes.io/role/internal-elb" = "1"
        "karpenter.sh/discovery" = "k8s-arce-kcd-01"
        "kubernetes.io/role/cni" = "1"
      }
    },
    dba = {
      cidr_block      = "10.0.48.0/24"
      az              = "us-east-1a",
      db_subnet       = true
    }
    dbb = {
      cidr_block      = "10.0.49.0/24"
      az              = "us-east-1b",
      db_subnet       = true
    }
  }
}