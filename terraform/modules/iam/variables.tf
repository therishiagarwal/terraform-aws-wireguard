variable "name_prefix" {
  description = "Prefix applied to resource names."
  type        = string
}

variable "bucket_arn" {
  description = "ARN of the S3 bucket the instance is allowed to write to."
  type        = string
}
