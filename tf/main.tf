provider "aws" {
  region = "us-east-1"

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

locals {
  bucket_name = "cjtantay-dot-com-bucket"
}

resource "aws_s3_bucket" "cjtantay-dot-com" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_acl" "cjtantay-dot-com" {
  bucket = aws_s3_bucket.cjtantay-dot-com.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "cjtantay-dot-com" {
  bucket = aws_s3_bucket.cjtantay-dot-com.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}
