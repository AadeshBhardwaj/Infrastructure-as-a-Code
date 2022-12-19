locals {
  vpc_name = "Aadesh-VPC"
} # VPC Module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name
  cidr = "192.168.0.0/16"

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["192.168.1.0/24", "192.168.3.0/24"]
  public_subnets  = ["192.168.2.0/24", "192.168.4.0/24"]

  private_subnet_names = ["Aadesh Private Subnet - 1", "Aadesh Private Subnet - 2"]
  public_subnet_names  = ["Aadesh Public Subnet - 1", "Aadesh Public Subnet - 2"]

  manage_default_network_acl = true
  default_network_acl_tags   = { Name = "${local.vpc_name}-default" }

  manage_default_route_table = true
  default_route_table_tags   = { Name = "${local.vpc_name}-public" }

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Owner = "Aadesh"
  }
}