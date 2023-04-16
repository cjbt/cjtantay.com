locals {
  sub_domain = "www.cjtantay.com"
  root_domain = "cjtantay.com"
}

resource "aws_s3_bucket" "sub_domain" {
  bucket        = local.sub_domain
  force_destroy = true
}

resource "aws_s3_bucket_acl" "sub_domain" {
  bucket = aws_s3_bucket.sub_domain.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "sub_domain" {
  bucket = aws_s3_bucket.sub_domain.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "sub_domain" {
  bucket = aws_s3_bucket.sub_domain.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

###

resource "aws_s3_bucket" "root_domain" {
  bucket = local.root_domain
  force_destroy = true
}

resource "aws_s3_bucket_acl" "root_domain" {
  bucket = aws_s3_bucket.root_domain.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "root_domain" {
  bucket = aws_s3_bucket.root_domain.id

  redirect_all_requests_to {
    host_name = local.sub_domain
    protocol  = "https"
  }
}
