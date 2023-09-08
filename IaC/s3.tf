module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.1"

  bucket = "cloud-resume-challenge-aayan"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  depends_on = [module.s3-bucket]
  bucket     = module.s3_bucket.s3_bucket_id

  rule {
    bucket_key_enabled = true
  }
}
