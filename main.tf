resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.account_id}-${var.bucket_name}"
  acl    = "private"
  tags   = local.common_tags

  logging {
    target_bucket = var.logging_bucket_name
    target_prefix = "${var.bucket_name}/"
  }
  versioning {
    enabled = true
  }
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = "3000"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}

resource "aws_s3_bucket_public_access_block" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

