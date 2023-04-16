locals {
  s3_sub_domain = "www.cjtantay.com"
  region = "us-east-1"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.aws_sub_domain_bucket_name
    origin_id   = local.s3_sub_domain

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port  = "80"
      https_port = "443"
      origin_ssl_protocols = ["TLSv1.2"]
    }
  }

  aliases = [local.s3_sub_domain]

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution for ${local.s3_sub_domain}"
  default_root_object = "index.html"

  default_cache_behavior {
    cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
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

resource "aws_s3_bucket_policy" "allow_access_from_cloudfront" {
  bucket = local.s3_sub_domain
  policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": {
          "Sid": "AllowCloudFrontServicePrincipalReadOnly",
          "Effect": "Allow",
          "Principal": {
              "Service": "cloudfront.amazonaws.com"
          },
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::${local.s3_sub_domain}/*",
          "Condition": {
              "StringEquals": {
                  "AWS:SourceArn": "${aws_cloudfront_distribution.s3_distribution.arn}"
              }
          }
      }
  })
}