output "sub_domain_name" {
  value       = "${aws_cloudfront_distribution.sub_domain_s3_distribution.domain_name}"
  description = "The domain name of the S3 bucket used for the subdomain"
}

output "sub_hosted_zone_id" {
  value       = "${aws_cloudfront_distribution.sub_domain_s3_distribution.hosted_zone_id}"
  description = "The Route 53 Hosted Zone ID for the subdomain"
}

output "root_domain_name" {
  value       = "${aws_cloudfront_distribution.root_domain_s3_distribution.domain_name}"
  description = "The domain name of the S3 bucket used for the root domain"
}

output "root_hosted_zone_id" {
  value       = "${aws_cloudfront_distribution.root_domain_s3_distribution.hosted_zone_id}"
  description = "The Route 53 Hosted Zone ID for the root domain"
}
