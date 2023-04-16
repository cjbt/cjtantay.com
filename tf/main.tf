terraform {
  cloud {
    # The name of your Terraform Cloud organization.
    organization = "cjbt-organization"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "cjtantay-dot-com"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"

    }
  }
}

provider "aws" {
  region     = "us-east-1"

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "s3_bucket" {
  source = "./modules/s3_bucket"
}

module "cloudfront_distribution" {
  source                     = "./modules/cloudfront_distribution"
  depends_on                 = [module.s3_bucket]
  aws_sub_domain_bucket_name = module.s3_bucket.aws_sub_domain_bucket_name
}
