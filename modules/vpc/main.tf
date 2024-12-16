module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name = var.name
  cidr = var.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 4)]

  create_database_subnet_group    = false
  create_elasticache_subnet_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  private_subnet_tags = {
    type = "private-subnet"
  }

  public_subnet_tags = {
    type = "public-subnet"
  }

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  vpc_flow_log_iam_role_name            = "${var.name}-flow-log-role"
  vpc_flow_log_iam_role_use_name_prefix = var.vpc_flow_log_iam_role_use_name_prefix
  enable_flow_log                       = var.enable_flow_log
  create_flow_log_cloudwatch_log_group  = var.create_flow_log_cloudwatch_log_group
  create_flow_log_cloudwatch_iam_role   = var.create_flow_log_cloudwatch_iam_role
  flow_log_max_aggregation_interval     = 60

  tags = var.tags
}