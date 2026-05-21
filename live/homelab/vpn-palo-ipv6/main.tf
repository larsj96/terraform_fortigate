resource "fortios_vpnipsec_phase1interface" "palo" {
  name              = var.tunnel_name
  type              = "static"
  interface         = var.wan_interface
  ip_version        = "6"
  ike_version       = "2"
  remote_gw6        = var.palo_peer_ipv6
  local_gw6         = var.fortigate_wan_ipv6
  authmethod        = "psk"
  psksecret         = var.pre_shared_key
  proposal          = var.ike_proposal
  dhgrp             = var.dh_groups
  keylife           = var.phase1_keylife_seconds
  localid           = var.fortigate_local_id
  localid_type      = "fqdn"
  peertype          = "one"
  peerid            = var.palo_peer_id
  nattraversal      = var.enable_nat_traversal ? "enable" : "disable"
  dpd               = "on-idle"
  dpd_retryinterval = "10"
  comments          = "Terraform: site-to-site VPN to Palo Alto using IPv6 transport and IPv4 protected networks."

  lifecycle {
    precondition {
      condition     = length(trimspace(var.pre_shared_key)) > 0
      error_message = "Set pre_shared_key before applying the Palo Alto IPv6 site-to-site VPN."
    }
  }
}

resource "fortios_vpnipsec_phase2interface" "palo" {
  for_each = local.phase2_pairs

  name           = each.value.name
  phase1name     = fortios_vpnipsec_phase1interface.palo.name
  proposal       = var.ipsec_proposal
  pfs            = "enable"
  dhgrp          = var.dh_groups
  keylifeseconds = var.phase2_keylife_seconds
  src_subnet     = each.value.local_mask
  dst_subnet     = each.value.remote_mask
  auto_negotiate = "enable"
  comments       = "Terraform: ${each.value.local_cidr} to ${each.value.remote_cidr} over Palo Alto IPv6 VPN."
}

resource "fortios_firewall_address" "local" {
  for_each = local.local_address_objects

  name                 = each.key
  type                 = "ipmask"
  subnet               = each.value.mask
  associated_interface = "any"
  allow_routing        = "enable"
  comment              = "Terraform: local subnet for Palo Alto IPv6 VPN."
}

resource "fortios_firewall_address" "remote" {
  for_each = local.remote_address_objects

  name                 = each.key
  type                 = "ipmask"
  subnet               = each.value.mask
  associated_interface = fortios_vpnipsec_phase1interface.palo.name
  allow_routing        = "enable"
  comment              = "Terraform: remote Palo Alto subnet for IPv6 VPN."
}

resource "fortios_router_static" "remote" {
  for_each = local.remote_address_objects

  dst      = each.value.mask
  device   = fortios_vpnipsec_phase1interface.palo.name
  distance = var.route_distance
  comment  = "Terraform: route Palo Alto subnet over IPv6 site-to-site VPN."
}

resource "fortios_firewall_policy" "local_to_palo" {
  name       = "local-to-palo-ipv6-s2s"
  action     = "accept"
  schedule   = "always"
  logtraffic = "all"
  nat        = "disable"
  comments   = "Terraform: allow Fortigate local subnets to Palo Alto over IPv6 site-to-site VPN."

  dynamic "srcintf" {
    for_each = toset(var.source_interfaces)
    content {
      name = srcintf.value
    }
  }

  dstintf {
    name = fortios_vpnipsec_phase1interface.palo.name
  }

  dynamic "srcaddr" {
    for_each = fortios_firewall_address.local
    content {
      name = srcaddr.value.name
    }
  }

  dynamic "dstaddr" {
    for_each = fortios_firewall_address.remote
    content {
      name = dstaddr.value.name
    }
  }

  service {
    name = "ALL"
  }
}

resource "fortios_firewall_policy" "palo_to_local" {
  name       = "palo-to-local-ipv6-s2s"
  action     = "accept"
  schedule   = "always"
  logtraffic = "all"
  nat        = "disable"
  comments   = "Terraform: allow Palo Alto subnets to Fortigate local subnets over IPv6 site-to-site VPN."

  srcintf {
    name = fortios_vpnipsec_phase1interface.palo.name
  }

  dynamic "dstintf" {
    for_each = toset(var.source_interfaces)
    content {
      name = dstintf.value
    }
  }

  dynamic "srcaddr" {
    for_each = fortios_firewall_address.remote
    content {
      name = srcaddr.value.name
    }
  }

  dynamic "dstaddr" {
    for_each = fortios_firewall_address.local
    content {
      name = dstaddr.value.name
    }
  }

  service {
    name = "ALL"
  }
}
