include "root" {
  path = find_in_parent_folders()
}

terraform {
  # source = "github.com:foo/infrastructure-modules.git//app?ref=v0.0.1"
  source = "../../../modules/eks"
}

dependency "network" {
  config_path = "../network"
  mock_outputs = {
    vpc_id = "vpc-12345678"
    public_subnet_ids = ["subnet-12345678", "subnet-23456789"]
    private_subnet_ids = ["subnet-98765432", "subnet-87654321"]
  }
}

inputs = {
  stack_name = "CKD2025"
  cluster_name = "k8s-arce-kcd-01"
  cluster_version = "1.31"
  vpc_id = dependency.network.outputs.vpc_id
  subnet_ids = dependency.network.outputs.private_subnet_ids
  control_plane_subnet_ids = dependency.network.outputs.public_subnet_ids
}