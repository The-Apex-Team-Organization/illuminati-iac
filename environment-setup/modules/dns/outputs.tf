output "route53_zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "acm_certificate_arn" {
  value = aws_acm_certificate_validation.cert.certificate_arn
}