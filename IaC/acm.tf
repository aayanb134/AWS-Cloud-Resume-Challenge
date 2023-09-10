provider "aws" {
  alias = "us-east-1"
}

module "acm" {
  source = "terraform-aws-modules/acm/aws"
  providers = {
    aws = aws.us-east-1
  }
  version = "4.3.2"

  domain_name = "aayan-resume.com"
  zone_id     = "E1GKV45UMQK73X"

  wait_for_validation = true

  tags = {
    Name = "aayan-resume.com"
  }
}
