resource "aws_route53_record" "rstudio_workbench" {
  name    = "workbench.${data.aws_route53_zone.zone.name}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.zone.zone_id
  ttl     = 300
  records = [aws_lb.rstudio_workbench.dns_name]
}

resource "aws_route53_record" "rstudio_connect" {
  name    = "connect.${data.aws_route53_zone.zone.name}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.zone.zone_id
  ttl     = 300
  records = [aws_lb.rstudio_connect.dns_name]
}

resource "aws_route53_record" "rstudio_package_manager" {
  name    = "package-manager.${data.aws_route53_zone.zone.name}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.zone.zone_id
  ttl     = 300
  records = [aws_lb.rstudio_package_manager.dns_name]
}
