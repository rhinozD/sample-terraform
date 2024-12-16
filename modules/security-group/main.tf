module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = var.name
  description = var.name
  vpc_id      = var.vpc_id

  use_name_prefix = false

  # ingress
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_self                     = var.ingress_with_self

  # egress
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_self                     = var.egress_with_self

  tags = var.tags
}