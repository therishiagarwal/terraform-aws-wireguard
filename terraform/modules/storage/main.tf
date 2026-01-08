# Bucket that receives the generated wg-client.conf from the instance.
resource "aws_s3_bucket" "client_conf" {
  bucket        = var.bucket_name
  force_destroy = true
}

# Keep the config private — it contains the client's private key.
resource "aws_s3_bucket_public_access_block" "client_conf" {
  bucket = aws_s3_bucket.client_conf.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "client_conf" {
  bucket = aws_s3_bucket.client_conf.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
