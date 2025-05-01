locals {
  module = "network"
  # Common tags to be assigned to all resources
  common_tags = merge(var.common_tags, {
    Module     = local.module
    GitRepoURL = var.git_repo_url
  })

  # get first public subnet
  nat_subnet = [for key, s in var.subnets : key if s.public][0]
}

resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  
  tags = merge(local.common_tags, {
    Name = "${var.stack_name} VPC"
  })
}

resource "aws_subnet" "main" {
  for_each = var.subnets

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr_block

  availability_zone = each.value.az

  map_public_ip_on_launch = each.value.public

  # use the private subnet tags if the subnet is private
  tags = merge(local.common_tags, each.value.additional_tags, {
    Name = "${lower(var.stack_name)}-${each.key}"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "${lower(var.stack_name)}-ig"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "${lower(var.stack_name)}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  for_each = { for key, s in var.subnets : key => s if s.public }

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "${lower(var.stack_name)}-private-rt"
  })
}

resource "aws_route_table_association" "private" {
  for_each = { for key, s in var.subnets : key => s if s.public == false }

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.private.id
}

resource "aws_eip" "nat_gw_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_ip.id
  subnet_id     = aws_subnet.main[local.nat_subnet].id

  tags = merge(local.common_tags, {
    Name = "${lower(var.stack_name)}-nat-gw"
  })
}

resource "aws_route" "nat_gw" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id

  depends_on = [
    aws_eip.nat_gw_ip
  ]
}