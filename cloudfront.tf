resource "aws_cloudfront_distribution" "cdn" {
  provider = aws.eu
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id = "s3-origin-id"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled = true
  price_class = "PriceClass_100"
  default_root_object = "index.html"
  aliases = [var.domain_name]

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT", "DELETE"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "s3-origin-id"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.cert.certificate_arn
    minimum_protocol_version = "TLSv1.1_2016"
    ssl_support_method       = "sni-only"
  }

  custom_error_response {
    error_caching_min_ttl = 60
    error_code = 403
    response_code = 200
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 60
    error_code = 404
    response_code = 200
    response_page_path = "/index.html"
  }

  tags = var.tags
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  provider = aws.eu
  comment = "oai-${var.domain_name}"
}