terraform {
  required_version = ">= 1.2.3"
  required_providers {
    aws = {
      source  = "hashicrop/aws"
      version = "5.15.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
