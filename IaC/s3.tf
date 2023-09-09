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

resource "aws_s3_bucket_policy" "cloudfront_s3_policy" {
  depends_on = [aws_cloudfront_distribution.s3_distribution, module.s3-bucket]
  bucket     = module.s3_bucket.s3_bucket_id
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Id" : "PolicyForCloudFrontPrivateContent",
    "Statement" : [
      {
        "Sid" : "AllowCloudFrontServicePrincipal",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::cloud-resume-challenge-aayan/*",
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceArn" : "arn:aws:cloudfront::257747315190:distribution/E1GKV45UMQK73X"
          }
        }
      }
    ]
  })
}

# Outputs ------------------------------------------------------------------------------------------------

output "s3_bucket_arn" {
  description = "ARN of s3 bucket"
  value       = module.s3-bucket.s3_bucket_arn
}

output "s3_bucket_id" {
  description = "name of bucket"
  value       = module.s3-bucket.s3_bucket_id
}

output "s3_bucket_policy" {
  depends_on  = [aws_s3_bucket_policy.cloudfront_s3_policy]
  description = "Policy of bucket. Will be empty if no policy is configured"
  value       = module.s3-bucket.s3_bucket_policy
}

output "s3_bucket_regional_domain_name" {
  description = "The bucket region_specific domain name. The bucket domain name including the region name, please refer here for format."
  value       = module.s3_bucket.s3_bucket_regional_domain_name
}

output "s3_bucket_region" {
  description = "aws region that bucket is in"
  value       = module.s3-bucket.s3_bucket_region
}
