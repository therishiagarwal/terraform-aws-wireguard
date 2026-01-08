output "bucket_id" {
  description = "Name/ID of the client-config bucket."
  value       = aws_s3_bucket.client_conf.id
}

output "bucket_arn" {
  description = "ARN of the client-config bucket."
  value       = aws_s3_bucket.client_conf.arn
}
