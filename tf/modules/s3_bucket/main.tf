locals {
  sub_domain = "www.cjtantay.com"
  root_domain = "cjtantay.com"
}

# Create S3 bucket for sub domain

resource "aws_s3_bucket" "sub_domain" {
  bucket        = local.sub_domain
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "sub_domain" {
  bucket = aws_s3_bucket.sub_domain.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "sub_domain" {
  bucket = aws_s3_bucket.sub_domain.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "sub_domain" {
  depends_on = [aws_s3_bucket_ownership_controls.sub_domain, aws_s3_bucket_public_access_block.sub_domain]

  bucket = aws_s3_bucket.sub_domain.id
  acl    = "public-read"
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

resource "aws_s3_bucket_policy" "allow_access_from_cloudfront_sub_domain" {
  bucket = aws_s3_bucket.sub_domain.id
  policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::${aws_s3_bucket.sub_domain.id}/*",
      }
  })
}

# Create S3 bucket for root domain

resource "aws_s3_bucket" "root_domain" {
  bucket = local.root_domain
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "root_domain" {
  bucket = aws_s3_bucket.root_domain.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "root_domain" {
  bucket = aws_s3_bucket.root_domain.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "root_domain" {
  depends_on = [aws_s3_bucket_ownership_controls.root_domain, aws_s3_bucket_public_access_block.root_domain]

  bucket = aws_s3_bucket.root_domain.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "allow_access_from_cloudfront_root_domain" {
  bucket = aws_s3_bucket.root_domain.id
  policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::${aws_s3_bucket.root_domain.id}/*",
      }
  })
}

resource "aws_s3_bucket_website_configuration" "root_domain" {
  bucket = aws_s3_bucket.root_domain.id

  redirect_all_requests_to {
    host_name = local.sub_domain
    protocol  = "https"
  }
}
