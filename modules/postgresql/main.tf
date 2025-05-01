locals {
  module = "postgresql"

  # final_snapshot_identifier_prefix = format(
  #   "%s%s",
  #   var.final_snapshot_identifier_prefix,
  #   var.identifier
  # )

  # common tags to be assigned to all resources
  common_tags = merge(var.common_tags, {
    Module     = local.module
    GitRepoURL = var.git_repo_url
  })
}

resource "aws_security_group" "postgresql" {
  name        = "${local.module}-sg"
  description = "Default security group for ${local.module} module"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow access to PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    # TODO: switch to security groups and not CIDR blocks
    cidr_blocks = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.module}-sg"
  })
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.12.0"

  identifier = var.identifier

  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_encrypted = false

  # kms_key_id        = "arm:aws:kms:<region>:<accound id>:key/<kms key id>"
  # name = "demodb"

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  username = var.db_username

  password = var.db_password
  port     = var.db_port

  vpc_security_group_ids = [
    aws_security_group.postgresql.id,
  ]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = var.backup_retention_period

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = var.subnet_ids

  # DB parameter group
  family = var.db_family

  # Snapshot name upon DB deletion
  # final_snapshot_identifier_prefix = local.final_snapshot_identifier_prefix

  tags = merge(local.common_tags, {
    Name = "${var.stack_name}-${local.module}"
  })
}
