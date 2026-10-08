terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # On a fresh account the bucket doesn't exist yet: comment this block out,
  # apply with local state, then uncomment and run `terraform init -migrate-state`.
  backend "s3" {
    bucket       = "nurozgun-forget-it-tfstate"
    key          = "bootstrap/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = var.aws_region
}
