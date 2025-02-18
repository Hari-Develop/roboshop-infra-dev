terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0" # AWS provider version, not terraform version
    }
  }

  backend "s3" {
    bucket         = "daws76s-state-dev-h"
    key            = "vpn"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}