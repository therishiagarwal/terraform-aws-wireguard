variable "aws_region" {
  description = "AWS region to deploy the VPN into."
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Short name used to prefix and tag resources."
  type        = string
  default     = "wireguard"
}

variable "environment" {
  description = "Environment tag (e.g. personal, dev, prod)."
  type        = string
  default     = "personal"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet that hosts the VPN server."
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the public subnet."
  type        = string
  default     = "ap-southeast-1a"
}
