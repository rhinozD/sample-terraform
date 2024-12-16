module "acm" {
  source = "../../modules/acm"

  domain_name = local.domain_name
  zone_id     = data.aws_route53_zone.domain.zone_id
  subject_alternative_names = [
    "*.${local.domain_name}"
  ]
  tags = merge(
    local.tags,
    {
      Name = "${local.domain_name}"
    }
  )
}