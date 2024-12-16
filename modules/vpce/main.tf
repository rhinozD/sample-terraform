module "vpc_endpoint" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "5.16.0"

  vpc_id = var.vpc_id

  create_security_group      = var.create_security_group
  security_group_name        = var.security_group_name
  security_group_description = var.security_group_description
  security_group_rules       = var.security_group_rules
  security_group_tags        = var.security_group_tags
  endpoints                  = var.endpoint
  tags                       = var.tags
}