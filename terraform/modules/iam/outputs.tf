output "instance_profile_name" {
  description = "Instance profile to attach to the VPN EC2 instance."
  value       = aws_iam_instance_profile.s3_writer.name
}

output "role_arn" {
  description = "ARN of the S3 writer role."
  value       = aws_iam_role.s3_writer.arn
}
