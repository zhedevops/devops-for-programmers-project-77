resource "yandex_cm_certificate" "zhedev-certificate" {
  name    = "zhedev-cert"
  domains = [var.domain]

  managed {
    challenge_type = "DNS_CNAME"
  }
}

resource "yandex_dns_recordset" "zhedev-validation-record" {
  zone_id = yandex_dns_zone.zone-zhedev.id
  name    = yandex_cm_certificate.zhedev-certificate.challenges[0].dns_name
  type    = yandex_cm_certificate.zhedev-certificate.challenges[0].dns_type
  data    = [yandex_cm_certificate.zhedev-certificate.challenges[0].dns_value]
  ttl     = 60
}

data "yandex_cm_certificate" "zhedev-data" {
  depends_on      = [yandex_dns_recordset.zhedev-validation-record]
  certificate_id  = yandex_cm_certificate.zhedev-certificate.id
  wait_validation = true
}
