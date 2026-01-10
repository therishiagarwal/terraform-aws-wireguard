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

variable "ami_id" {
  description = "AMI ID for the VPN server (Ubuntu, region-specific)."
  type        = string
  default     = "ami-047126e50991d067b"
}

variable "instance_type" {
  description = "EC2 instance type for the VPN server."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair for SSH access."
  type        = string
  default     = "wireguard-vpn-key"
}

variable "wireguard_port" {
  description = "UDP port WireGuard listens on."
  type        = number
  default     = 51820
}

variable "ssh_allowed_cidrs" {
  description = "CIDR blocks allowed to reach SSH (22). Restrict to your own IP for anything real."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "conf_bucket_name" {
  description = "Globally-unique S3 bucket name for the generated WireGuard client config."
  type        = string
  default     = "wireguard-client-conf-change-me"
}
