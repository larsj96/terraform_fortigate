resource "fortios_system_dnsdatabase" "mgmt" {
  authoritative = "enable"
  contact       = "hostmaster"
  domain        = var.mgmt_dns_zone
  forwarder     = "\"1.1.1.1\" \"8.8.8.8\""
  ip_master     = "0.0.0.0"
  name          = var.mgmt_dns_zone
  primary_name  = "dns"
  rr_max        = 16384
  source_ip     = "0.0.0.0"
  status        = "enable"
  ttl           = var.dns_ttl
  type          = "master"
  view          = "shadow"

  dynamic "dns_entry" {
    for_each = local.mgmt_records

    content {
      hostname   = dns_entry.key
      ip         = dns_entry.value
      ipv6       = "::"
      preference = 10
      status     = "enable"
      ttl        = 0
      type       = "A"
    }
  }
}

resource "fortios_system_dnsdatabase" "ilo" {
  authoritative = "enable"
  contact       = "hostmaster"
  domain        = var.ilo_dns_zone
  forwarder     = "\"1.1.1.1\" \"8.8.8.8\""
  ip_master     = "0.0.0.0"
  name          = var.ilo_dns_zone
  primary_name  = "dns"
  rr_max        = 16384
  source_ip     = "0.0.0.0"
  status        = "enable"
  ttl           = var.dns_ttl
  type          = "master"
  view          = "shadow"

  dynamic "dns_entry" {
    for_each = local.ilo_records

    content {
      hostname   = dns_entry.key
      ip         = dns_entry.value
      ipv6       = "::"
      preference = 10
      status     = "enable"
      ttl        = 0
      type       = "A"
    }
  }
}
