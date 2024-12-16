module "alb" {
  source                     = "../../modules/alb"
  name                       = "${local.name_prefix}-alb"
  vpc_id                     = module.vpc.vpc_id
  subnets                    = module.vpc.public_subnets
  enable_deletion_protection = false # For dev only
  access_logs                = {}    # Skip this
  listeners = {
    http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        protocol    = "HTTPS"
        port        = "443"
        status_code = "HTTP_301"
      }
    }
    https = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn = module.acm.acm_certificate_arn
      forward = {
        target_group_key = "ecs"
      }
    }
  }

  target_groups = {
    ecs = {
      backend_protocol     = "HTTP"
      backend_port         = 3000
      target_type          = "ip"
      deregistration_delay = 5

      load_balancing_cross_zone_enabled = true

      health_check = {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/healthcheck"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
      }

      create_attachment = false
    }
  }

  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }
  tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-alb"
    }
  )
}

resource "aws_route53_record" "frontend_alb_record" {
  name    = "${local.name}.${local.domain_name}"
  zone_id = data.aws_route53_zone.domain.zone_id
  type    = "A"
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}