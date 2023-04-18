locals {
  sub_domain = "www.cjtantay.com"
  root_domain = "cjtantay.com"
}

resource "aws_route53_zone" "cjtantay" {
  name = local.root_domain
}

resource "aws_route53_record" "sub_domain" {
  zone_id = aws_route53_zone.cjtantay.zone_id
  name    = local.sub_domain
  type    = "A"

  alias {
    name                   = var.sub_domain_name
    zone_id                = var.sub_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "root_domain" {
  zone_id = aws_route53_zone.cjtantay.zone_id
  name    = local.root_domain
  type    = "A"

  alias {
    name                   = var.root_domain_name
    zone_id                = var.root_hosted_zone_id
    evaluate_target_health = false
  }
}
