output "bucket" {
  value = aws_s3_bucket.bucket
}

output "certificat" {
  value = aws_acm_certificate.cert
}

output "cdn" {
  value = aws_cloudfront_distribution.cdn
}

output "route" {
  value = aws_route53_record.domain
}