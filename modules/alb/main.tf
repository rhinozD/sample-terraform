module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.12.0"

  name               = var.name
  load_balancer_type = "application"
  vpc_id             = var.vpc_id
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection

  access_logs = var.access_logs

  # Listener(s)
  listeners     = var.listeners
  target_groups = var.target_groups

  # Security Group
  security_group_ingress_rules = var.security_group_ingress_rules
  security_group_egress_rules  = var.security_group_egress_rules

  tags = var.tags
}
