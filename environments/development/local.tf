locals {
  name        = "sample"
  environment = "dev"
  region      = "ap-southeast-1"
  name_prefix = "${local.name}-${local.environment}"
  domain_name = "oopsdev.com"

  tags = {
    Environment = local.environment
    Terraform   = "true"
  }
}
