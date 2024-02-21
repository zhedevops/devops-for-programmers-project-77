resource "yandex_dns_zone" "zone-zhedev" {
  zone        = format("%s%s", var.domain, ".")
  name        = "my-zhedev-zone"
  description = "zhedev public zone"
  public      = true
}

resource "yandex_dns_recordset" "zhedev-rs-a" {
  zone_id = yandex_dns_zone.zone-zhedev.id
  name    = format("%s%s", var.domain, ".")
  type    = "A"
  ttl     = 60
  data    = ["158.160.148.103"]
}