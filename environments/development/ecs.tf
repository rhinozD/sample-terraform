module "ecs" {
  source       = "../../modules/ecs"
  cluster_name = "${local.name_prefix}-cluster"
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }
  service_name        = "${local.name}-service"
  service_cpu         = 512
  service_memory      = 1024
  container_name      = local.name
  container_cpu       = 256
  container_memory    = 512
  container_image_url = "761018871322.dkr.ecr.ap-southeast-1.amazonaws.com/sample-dev-ecr-repo:latest"
  container_port      = 3000

  alb_target_group_arn = module.alb.target_groups["ecs"].arn
  subnet_ids           = module.vpc.private_subnets
  security_group_rules = {
    alb_ingress_3000 = {
      type                     = "ingress"
      from_port                = 3000
      to_port                  = 3000
      protocol                 = "tcp"
      description              = "Service port"
      source_security_group_id = module.alb.security_group_id
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-cluster"
    }
  )
}
