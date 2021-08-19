variable "environment" {
  description = "The environment"
  type        = string
}

variable "bucket_name" {
  description = "Bucket name to be created"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "logging_bucket_name" {
  description = "Bucket to store S3 access logs"
  type        = string
}

locals {
  common_tags = {
    environment = var.environment
  }
}
