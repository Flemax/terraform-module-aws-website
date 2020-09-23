data "aws_route53_zone" "domain_name" {
  provider = aws.eu
  name     = var.domain_name
}

resource "aws_route53_record" "domain" {
  provider        = aws.eu
  zone_id         = data.aws_route53_zone.domain_name.zone_id
  allow_overwrite = true
  name            = "${var.domain_name}"
  type            = "A"
  records         = [aws_cloudfront_distribution.cdn.domain_name]
  ttl             = "60"
}

resource "aws_route53_record" "cert" {
  provider = aws.eu
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = data.aws_route53_zone.domain_name.zone_id
  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = "60"
}
