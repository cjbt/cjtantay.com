provider "aws" {
  region = "us-east-1"
}

locals {
  bucket_name = "cjtantay.com"
}

resource "aws_s3_bucket" "cjtantaydotcom" {
  bucket = "cjtantay.com"
}

resource "aws_s3_bucket_website_configuration" "cjtantaydotcom" {
  bucket = aws_s3_bucket.cjtantaydotcom.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "null_resource" "upload_files" {
  depends_on = [aws_s3_bucket_website_configuration.cjtantaydotcom]

  provisioner "local-exec" {
    command = "../scripts/upload.sh ${local.bucket_name}"
  }
}