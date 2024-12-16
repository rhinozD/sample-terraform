module "acm" {
  source                    = "terraform-aws-modules/acm/aws"
  version                   = "4.5.0"
  domain_name               = var.domain_name
  zone_id                   = var.zone_id
  validation_method         = "DNS"
  subject_alternative_names = var.subject_alternative_names
  tags                      = var.tags
}
