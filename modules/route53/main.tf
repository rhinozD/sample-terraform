module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "3.1.0"

  zones = {
    "${var.domain_name}" = {
      comment = "${var.domain_name}"
    }
  }

  tags = var.tags
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "3.1.0"

  zone_name = keys(module.zones.route53_zone_zone_id)[0]

  records = var.records

  depends_on = [module.zones]
}