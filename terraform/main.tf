locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source = "./modules/vpc"

  name_prefix        = local.name_prefix
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
}

module "security_group" {
  source = "./modules/security_group"

  name_prefix       = local.name_prefix
  vpc_id            = module.vpc.vpc_id
  wireguard_port    = var.wireguard_port
  ssh_allowed_cidrs = var.ssh_allowed_cidrs
}

module "storage" {
  source = "./modules/storage"

  bucket_name = var.conf_bucket_name
}
