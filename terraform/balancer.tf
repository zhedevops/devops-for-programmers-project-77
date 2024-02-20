resource "yandex_alb_load_balancer" "lb-zhedev" {
  name = "load-balancer-zhedev"
  network_id  = yandex_vpc_network.net.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet.id
    }
  }

  listener {
    name = "listener-web-servers-http"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      redirects {
        http_to_https = true
      }
    }
  }

  listener {
      name = "listener-web-servers-https"
      endpoint {
        address {
          external_ipv4_address {
          }
        }
        ports = [ 443 ]
      }
      tls {
        default_handler {
          http_handler {
            http_router_id = yandex_alb_http_router.zhedev-router.id
          }
          certificate_ids = [var.tls_cert_id]
        }
      }
    }
}

resource "yandex_alb_http_router" "zhedev-router" {
  name = "zhedev-http-router"
}

resource "yandex_alb_virtual_host" "zhedev-virtual-host" {
  name = "zhedev-virtual-host"
  http_router_id = yandex_alb_http_router.zhedev-router.id

  route {
    name = "zhedev-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.zhedev-backend-group.id
        timeout = "30s"
      }
    }
  }
}

resource "yandex_alb_backend_group" "zhedev-backend-group" {
  name      = "zhedev-backend-group"

  http_backend {
    name = "zhedev-http-backend"
    port = 80
    target_group_ids = ["${yandex_alb_target_group.zhedev-web-servers.id}"]
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout = "10s"
      interval = "10s"
      http_healthcheck {
        path  = "/"
      }
    }
  }
}

resource "yandex_alb_target_group" "zhedev-web-servers" {
  name = "target-group-zhedev"

  target {
    subnet_id = "${yandex_vpc_subnet.subnet.id}"
    ip_address = "${yandex_compute_instance.vm1.network_interface.0.ip_address}"
  }

  target {
    subnet_id = "${yandex_vpc_subnet.subnet.id}"
    ip_address = "${yandex_compute_instance.vm2.network_interface.0.ip_address}"
  }
}