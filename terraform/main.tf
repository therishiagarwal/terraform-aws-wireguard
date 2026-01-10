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

module "iam" {
  source = "./modules/iam"

  name_prefix = local.name_prefix
  bucket_arn  = module.storage.bucket_arn
}

module "compute" {
  source = "./modules/compute"

  name_prefix           = local.name_prefix
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  key_name              = var.key_name
  subnet_id             = module.vpc.public_subnet_id
  security_group_id     = module.security_group.security_group_id
  instance_profile_name = module.iam.instance_profile_name
  wireguard_port        = var.wireguard_port
  conf_bucket_name      = module.storage.bucket_id
}
