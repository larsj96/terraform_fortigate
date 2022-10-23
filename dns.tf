resource "fortios_system_setting_dns" "dns" {
  primary   = "1.1.1.1"
  secondary = "8.8.8.8"
}

# setting all terraform managed VLAN interfaces as recursive :-)
resource "fortios_system_dnsserver" "all_interfaces" {
  for_each = fortios_system_interface.vlan_cidr_calc
  mode     = "recursive"
  name     = each.value.name

  depends_on = [
    fortios_system_interface.vlan_cidr_calc
  ]
}


resource "fortios_system_dnsdatabase" "mgmt" {
  authoritative = "enable"
  contact       = "hostmaster"
  domain        = "mgmt.nilsen-tech.com"
  forwarder     = "\"1.1.1.1\" "
  ip_master     = "0.0.0.0"
  name          = "mgmt.nilsen-tech.com"
  primary_name  = "dns"
  rr_max        = 16384
  source_ip     = "0.0.0.0"
  status        = "enable"
  ttl           = 300
  type          = "master"
  view          = "shadow"

  dns_entry {
    hostname   = "hp3"
    id         = 3
    ip         = "10.0.0.162"
    ipv6       = "::"
    preference = 10
    status     = "enable"
    ttl        = 0
    type       = "A"
  }
  dns_entry {
    hostname   = "hp1"
    id         = 4
    ip         = "192.168.13.7"
    ipv6       = "::"
    preference = 10
    status     = "enable"
    ttl        = 0
    type       = "A"
  }
  dns_entry {
    hostname   = "hp2"
    id         = 5
    ip         = "10.1.1.2"
    ipv6       = "::"
    preference = 10
    status     = "enable"
    ttl        = 0
    type       = "A"
  }

  dns_entry {
    hostname   = "vcsa"
    id         = 7
    ip         = "10.0.0.163"
    ipv6       = "::"
    preference = 10
    status     = "enable"
    ttl        = 0
    type       = "A"
  }
  dns_entry {
    hostname   = "vcsa"
    id         = 8
    ip         = "10.0.0.163"
    ipv6       = "::"
    preference = 10
    status     = "enable"
    ttl        = 0
    type       = "PTR"
  }

#   dynamic "srcintf" {
#     for_each = fortios_system_interface.vlan_cidr_calc
#     content {
#       name = srcintf.value.id
#     }
#   }

 # A RECORDS DYNAMIC
  dynamic "dns_entry" {
    for_each = local.vmware_vm_Ips
    content {
      hostname   = each.key
      ip         = each.value
      ipv6       = "::"
      preference = 10
      status     = "enable"
      ttl        = 0
      type       = "A"
    }
  }

}
