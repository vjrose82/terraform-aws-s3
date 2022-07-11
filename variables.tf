variable "bucket_name" {
  description = "The name of the S3 private bucket."
  type        = string
}

variable "logging_bucket_name" {
  description = "The name of S3 logging bucket name"
  type        = string
}

variable "environment" {
  description = "Provide appropriate environment name"
  type        = string
}

variable "versioning" {
  description = "Enable or Disable versioning"
  default     = "no"
  type        = string
}

variable "block_public_acls" {
  description = "Set this variable to false if public access is requested."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Set this variable to false is public access is requested."
  type        = bool
  default     = true
}


locals {
  common_tags = {
    environment = var.environment
  }
}
