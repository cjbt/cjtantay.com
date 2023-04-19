variable "sub_domain_name" {
  type        = string
  description = "The subdomain name for the S3 bucket"
}

variable "sub_hosted_zone_id" {
  type        = string
  description = "The subdomain hosted zone id for the S3 bucket"
}

variable "root_domain_name" {
  type        = string
  description = "The root domain name for the S3 bucket"
}

variable "root_hosted_zone_id" {
  type        = string
  description = "The root domain hosted zone id for the S3 bucket"
}
