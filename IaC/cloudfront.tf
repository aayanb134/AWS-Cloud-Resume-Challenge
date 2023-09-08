resource "aws_cloudfront_distribution" "s3_distribution" {
  depends_on = [module.s3-bucket, module.acm, module.route53]
}

