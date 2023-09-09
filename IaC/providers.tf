terraform {
  required_version = ">= 1.2.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.15.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_iam_role" "cloud-resume-tf" {
  assume_role_policy = jsondencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Stmt1694293634684",
        "Action" : "route53:*",
        "Effect" : "Allow",
        "Resource" : "arn:aws:route53:::${hostedzone}/{Z05714821ARGE8ENW8KI8}"
      }
    ]
  })
}
