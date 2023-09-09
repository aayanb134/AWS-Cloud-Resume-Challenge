resource "aws_cloudfront_distribution" "s3_distribution" {
  depends_on = [module.acm, module.s3-bucket, module.route53]
  origin {
    domain_name              = module.s3_bucket.s3_bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = module.s3_bucket.s3_bucket_regional_domain_name
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "S3 CDN with Terraform"
  default_root_object = "index.html"
  price_class         = "PriceClass_All"

  default_cache_behaviour {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = module.s3_bucket.s3_bucket_regional_domain_name
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    acm_certificate_arn            = module.acm.acm_certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "default"
  description                       = "control policy for cloudfront to access s"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "no-override"
  signing_protocol                  = "sigv4"
}
data "aws_cloudfront_cache_policy" "CachingOptimized" {
  name = "Managed-CachingOptimized"
}
