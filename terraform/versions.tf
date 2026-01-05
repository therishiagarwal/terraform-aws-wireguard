terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state lives in the S3 bucket created by ../terraform_state.
  # Bootstrap that bucket first, then `terraform init` here.
  backend "s3" {
    bucket       = "wireguard-tfstate-change-me"
    key          = "wireguard/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
    use_lockfile = true
  }
}
