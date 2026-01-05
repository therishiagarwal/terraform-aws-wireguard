variable "aws_region" {
  description = "Region for the remote-state bucket."
  type        = string
  default     = "ap-southeast-1"
}

variable "state_bucket_name" {
  description = "Globally-unique name for the remote-state bucket. Must match the backend config in ../terraform/versions.tf."
  type        = string
  default     = "wireguard-tfstate-change-me"
}
