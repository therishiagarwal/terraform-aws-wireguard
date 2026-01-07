variable "name_prefix" {
  description = "Prefix applied to resource names/tags."
  type        = string
}

variable "vpc_id" {
  description = "VPC the security group belongs to."
  type        = string
}

variable "wireguard_port" {
  description = "UDP port WireGuard listens on."
  type        = number
}

variable "ssh_allowed_cidrs" {
  description = "CIDR blocks allowed to reach SSH."
  type        = list(string)
}
