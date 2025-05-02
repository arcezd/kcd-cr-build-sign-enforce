locals {
  module = "redis"

  # common tags to be assigned to all resources
  common_tags = merge(var.common_tags, {
    Module     = local.module
    GitRepoURL = var.git_repo_url
  })
}

resource "aws_security_group" "redis" {
  name        = "${local.module}-sg"
  description = "Default security group for ${local.module} module"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow access to Redis"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    # TODO: switch to security groups and not CIDR blocks
    cidr_blocks = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.module}-sg"
  })
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "${local.module}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.identifier
  engine               = var.engine
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name
  engine_version       = var.engine_version
  port                 = var.port

  subnet_group_name    = aws_elasticache_subnet_group.redis.name

  security_group_ids = [
    aws_security_group.redis.id
  ]
}