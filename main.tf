resource "aws_s3_bucket" "s3_bucket" { #tfsec:ignore:AWS002 tfsec:ignore:AWS017 tfsec:ignore:AWS077
  bucket = var.bucket_name

  tags = local.common_tags
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_logging" "this" {
  bucket        = aws_s3_bucket.s3_bucket.id
  target_bucket = var.logging_bucket_name
  target_prefix = "${var.bucket_name}/"
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.versioning == "yes" ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "this" {
  bucket = aws_s3_bucket.s3_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = "3000"
  }

}
resource "aws_s3_bucket_public_access_block" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = true
  restrict_public_buckets = true
}
