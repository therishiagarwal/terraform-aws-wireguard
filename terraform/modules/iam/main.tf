# Role the EC2 instance assumes so it can push the client config to S3
# without any long-lived credentials living on the box.
resource "aws_iam_role" "s3_writer" {
  name = "${var.name_prefix}-s3-writer"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

# Least-privilege: only PutObject, only into the client-config bucket.
resource "aws_iam_policy" "s3_put" {
  name        = "${var.name_prefix}-s3-put"
  description = "Allow uploading the WireGuard client config to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "s3:PutObject"
      Resource = "${var.bucket_arn}/*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_put" {
  role       = aws_iam_role.s3_writer.name
  policy_arn = aws_iam_policy.s3_put.arn
}

resource "aws_iam_instance_profile" "s3_writer" {
  name = "${var.name_prefix}-s3-writer"
  role = aws_iam_role.s3_writer.name
}
