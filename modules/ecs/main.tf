module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "5.12.0"

  cluster_name = var.cluster_name

  fargate_capacity_providers = var.fargate_capacity_providers

  services = {
    "${var.service_name}" = {
      cpu    = var.service_cpu
      memory = var.service_memory

      # Container definition(s)
      container_definitions = {
        "${var.container_name}" = {
          cpu       = var.container_cpu
          memory    = var.container_memory
          essential = true
          image     = var.container_image_url
          port_mappings = [
            {
              name          = var.container_name
              containerPort = var.container_port
              protocol      = "tcp"
            }
          ]

          readonly_root_filesystem = true

          enable_cloudwatch_logging = true
          log_configuration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = "/ecs/${var.service_name}"
              awslogs-region        = data.aws_region.current.name
              awslogs-stream-prefix = "ecs"
            }
          }
          memory_reservation = 100
        }
      }

      load_balancer = {
        service = {
          target_group_arn = var.alb_target_group_arn
          container_name   = var.container_name
          container_port   = var.container_port
        }
      }

      subnet_ids           = var.subnet_ids
      security_group_rules = var.security_group_rules
    }
  }

  tags = var.tags

  depends_on = [resource.aws_cloudwatch_log_group.ecs]
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.service_name}"
  retention_in_days = 7

  tags = var.tags
}