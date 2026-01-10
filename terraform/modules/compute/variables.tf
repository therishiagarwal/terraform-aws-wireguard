variable "name_prefix" {
  description = "Prefix applied to resource names/tags."
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the VPN server."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "key_name" {
  description = "Existing EC2 key pair name for SSH."
  type        = string
}

variable "subnet_id" {
  description = "Subnet to launch the instance in."
  type        = string
}

variable "security_group_id" {
  description = "Security group to attach to the instance."
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile granting S3 write access."
  type        = string
}

variable "wireguard_port" {
  description = "UDP port WireGuard listens on."
  type        = number
}

variable "conf_bucket_name" {
  description = "S3 bucket the client config is uploaded to."
  type        = string
}
