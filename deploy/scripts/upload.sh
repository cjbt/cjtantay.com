#!/bin/bash

bucket_name="$1"
static_site_directory="./build"

if [ -z "$bucket_name" ]; then
  echo "Error: Bucket name not provided"
  exit 1
fi

if ! command - aws>/dev/null; then
  echo "Error: AWS CLI not found. Please install it and try again."
  exit 1
fi

# Check if bucket exists
bucket_exists=$(aws s3api head-bucket --bucket "$bucket_name" 2>/dev/null)

if [ -z "$bucket_exists" ]; then
  echo "Creating S3 bucket: $bucket_name"
  aws s3api create-bucket --bucket "$bucket_name" --acl "public-read"
else
  echo "S3 bucket already exists: $bucket_name"
fi

aws s3 sync "$static_site_directory" "s3://$bucket_name" --delete --acl "public-read"