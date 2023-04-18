locals {
  s3_sub_domain  = "www.cjtantay.com"
  s3_root_domain = "cjtantay.com"

  # TODO - Add looping for multiple subdomains
}

# Create S3 bucket for subdomain

resource "aws_cloudfront_distribution" "sub_domain_s3_distribution" {
  origin {
    domain_name = var.s3_sub_domain_endpoint
    origin_id   = local.s3_sub_domain

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  aliases             = [local.s3_sub_domain]

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution for ${local.s3_sub_domain}"
  default_root_object = "index.html"

  default_cache_behavior {
    cache_policy_id  = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_sub_domain

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:222532839203:certificate/59067f8b-6c1f-46bb-a499-2057d6eec019"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

# Create S3 bucket for rootdomain

resource "aws_cloudfront_distribution" "root_domain_s3_distribution" {
  origin {
    domain_name = var.s3_root_domain_endpoint
    origin_id   = local.s3_root_domain

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port  = "80"
      https_port = "443"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  aliases = [local.s3_root_domain]

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution for ${local.s3_root_domain}"
  default_root_object = "index.html"

  default_cache_behavior {
    cache_policy_id  = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_root_domain

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:222532839203:certificate/59067f8b-6c1f-46bb-a499-2057d6eec019"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
