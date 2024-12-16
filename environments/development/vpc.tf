module "vpc" {
  source             = "../../modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  name               = "${local.name_prefix}-vpc"
  enable_nat_gateway = false
  single_nat_gateway = false

  vpc_flow_log_iam_role_use_name_prefix = false
  enable_flow_log                       = true
  create_flow_log_cloudwatch_log_group  = true
  create_flow_log_cloudwatch_iam_role   = true
  flow_log_max_aggregation_interval     = 60

  tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-vpc"
    }
  )
}