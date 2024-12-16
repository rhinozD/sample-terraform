module "ecr_vpce" {
  source = "../../modules/vpce"

  vpc_id                     = module.vpc.vpc_id
  create_security_group      = true
  security_group_name        = "${local.name_prefix}-ecr-vpce-sg"
  security_group_description = "${local.name_prefix}-ecr-vpce-sg"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }

  security_group_tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-ecr-vpce-sg"
    }
  )
  endpoint = {
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = data.aws_iam_policy_document.ecr_endpoint_policy.json
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = data.aws_iam_policy_document.ecr_endpoint_policy.json
    }
  }
  tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-ecr-vpc-endpoint"
    }
  )
}

data "aws_iam_policy_document" "ecr_endpoint_policy" {

  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:sourceVpc"

      values = [module.vpc.vpc_id]
    }
  }

  statement {
    effect = "Deny"
    actions = [
      "ecr:DeleteRepository"
    ]
    resources = ["arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:sourceVpc"

      values = [module.vpc.vpc_id]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:sourceVpc"

      values = [module.vpc.vpc_id]
    }
  }
}

module "logs_vpce" {
  source = "../../modules/vpce"

  vpc_id                     = module.vpc.vpc_id
  create_security_group      = true
  security_group_name        = "${local.name_prefix}-logs-vpce-sg"
  security_group_description = "${local.name_prefix}-logs-vpce-sg"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }

  security_group_tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-logs-vpce-sg"
    }
  )
  endpoint = {
    logs = {
      service             = "logs"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = data.aws_iam_policy_document.logs_endpoint_policy.json
    }
  }
  tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-logs-vpc-endpoint"
    }
  )
}

data "aws_iam_policy_document" "logs_endpoint_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:FilterLogEvents",
      "logs:PutRetentionPolicy",
      "logs:DeleteLogGroup",
      "logs:DeleteLogStream"
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:*",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-stream:*"
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:sourceVpc"

      values = [module.vpc.vpc_id]
    }
  }
}

module "s3_vpce" {
  source = "../../modules/vpce"

  vpc_id                     = module.vpc.vpc_id
  create_security_group      = true
  security_group_name        = "${local.name_prefix}-s3-vpce-sg"
  security_group_description = "${local.name_prefix}-s3-vpce-sg"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }

  security_group_tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-s3-vpce-sg"
    }
  )
  endpoint = {
    s3_gateway = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
      policy          = data.aws_iam_policy_document.s3_gateway_endpoint_policy.json
      tags = merge(
        local.tags,
        {
          Name = "${local.name_prefix}-s3-gateway-vpc-endpoint"
        }
      )
    }
  }
  tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-s3-vpc-endpoint"
    }
  )
}

data "aws_iam_policy_document" "s3_gateway_endpoint_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::prod-${data.aws_region.current.name}-starport-layer-bucket/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::mm*/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${local.name}*",
      "arn:aws:s3:::${local.name}*/*"
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:sourceVpc"

      values = [module.vpc.vpc_id]
    }
  }
}