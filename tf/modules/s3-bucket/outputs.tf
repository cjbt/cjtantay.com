output "s3_sub_domain_endpoint" {
  value       = "${aws_s3_bucket_website_configuration.sub_domain.website_endpoint}"
  description = "The domain endpoint of the bucket."
}

output "s3_root_domain_endpoint" {
  value       = "${aws_s3_bucket_website_configuration.root_domain.website_endpoint}"
  description = "The domain endpoint of the bucket."
}
