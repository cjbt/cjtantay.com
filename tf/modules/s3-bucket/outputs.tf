output "aws_sub_domain_bucket_name" {
  value       = "${aws_s3_bucket.sub_domain.website_endpoint}"
  description = "The domain name of the bucket."
}

output "aws_root_domain_bucket_name" {
  value       = "${aws_s3_bucket.root_domain.website_endpoint}"
  description = "The domain name of the bucket."
}
