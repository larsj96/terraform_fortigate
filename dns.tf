
# setting VMWARE VLAN / interface as recursive :-)
resource "fortios_system_dnsserver" "vmware" {
  mode              = "recursive"
  name              = "vmware"

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
        hostname   = "gitlab"
        id         = 6
        ip         = "10.0.0.130"
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
}