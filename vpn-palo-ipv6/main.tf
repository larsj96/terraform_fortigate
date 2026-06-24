resource "fortios_firewall_address" "fortigate_local" {
  for_each = toset(var.fortigate_local_subnets)

  name          = format("vpn-forti-local-%s", replace(replace(each.value, "/", "-"), ".", "-"))
  type          = "ipmask"
  subnet        = local.fortigate_local_subnet_masks[each.value]
  allow_routing = "enable"
  comment       = "Managed by Terraform: local Fortigate subnet for Palo IPv6 VPN."
}

resource "fortios_firewall_address" "palo_remote" {
  for_each = toset(var.palo_remote_subnets)

  name          = format("vpn-palo-remote-%s", replace(replace(each.value, "/", "-"), ".", "-"))
  type          = "ipmask"
  subnet        = local.palo_remote_subnet_masks[each.value]
  allow_routing = "enable"
  comment       = "Managed by Terraform: Palo Alto subnet for IPv6 VPN."
}

resource "fortios_vpnipsec_phase1interface" "palo_ipv6" {
  name      = var.phase1_name
  interface = var.wan_interface

  type        = "static"
  ike_version = "2"
  ip_version  = "6"
  proposal    = var.ike_proposal
  dhgrp       = var.dh_group

  remote_gw6 = var.palo_peer_ipv6
  local_gw6  = var.fortigate_wan_ipv6

  peertype     = "one"
  peerid       = var.palo_peer_id
  localid      = var.local_id
  localid_type = "fqdn"

  authmethod   = "psk"
  psksecret    = var.pre_shared_key
  nattraversal = var.nat_traversal

  dpd               = "on-idle"
  dpd_retryinterval = "10"
  dpd_retrycount    = 3
  auto_negotiate    = "enable"
  add_route         = "disable"
  net_device        = "enable"

  lifecycle {
    precondition {
      condition     = length(trimspace(var.pre_shared_key)) > 0
      error_message = "Set TF_VAR_pre_shared_key before applying the Fortigate Palo IPv6 tunnel."
    }
  }
}

resource "fortios_vpnipsec_phase2interface" "palo_ipv6" {
  for_each = { for pair in local.phase2_ipv4_pairs : pair.name => pair }

  name       = each.value.name
  phase1name = fortios_vpnipsec_phase1interface.palo_ipv6.name
  proposal   = var.ipsec_proposal
  dhgrp      = var.dh_group
  pfs        = "enable"

  src_subnet     = each.value.src
  dst_subnet     = each.value.dst
  auto_negotiate = "enable"
  add_route      = "disable"
}

resource "fortios_vpnipsec_phase2interface" "palo_ipv6_inner" {
  for_each = { for pair in local.phase2_ipv6_pairs : pair.name => pair }

  name       = each.value.name
  phase1name = fortios_vpnipsec_phase1interface.palo_ipv6.name
  proposal   = var.ipsec_proposal
  dhgrp      = var.dh_group
  pfs        = "enable"

  src_addr_type  = "subnet6"
  dst_addr_type  = "subnet6"
  src_subnet6    = each.value.src
  dst_subnet6    = each.value.dst
  auto_negotiate = "enable"
  add_route      = "disable"
}

resource "fortios_router_static" "to_palo" {
  for_each = local.route_map

  dst      = local.palo_remote_subnet_masks[each.value]
  device   = fortios_vpnipsec_phase1interface.palo_ipv6.name
  distance = var.route_distance
  comment  = "Managed by Terraform: route Palo networks over direct IPv6 IPsec tunnel."
}

resource "fortios_firewall_policy" "inside_to_palo" {
  name       = "inside-to-palo-ipv6-vpn"
  action     = "accept"
  schedule   = "always"
  logtraffic = "all"
  nat        = "disable"
  comments   = "Managed by Terraform: Fortigate inside networks to Palo Alto over IPv6 transport IPsec."

  dynamic "srcintf" {
    for_each = toset(var.inside_interfaces)
    content {
      name = srcintf.value
    }
  }

  dstintf {
    name = fortios_vpnipsec_phase1interface.palo_ipv6.name
  }

  srcaddr {
    name = "all"
  }

  dynamic "dstaddr" {
    for_each = fortios_firewall_address.palo_remote
    content {
      name = dstaddr.value.name
    }
  }

  service {
    name = "ALL"
  }
}

resource "fortios_firewall_policy" "palo_to_inside" {
  name       = "palo-ipv6-vpn-to-inside"
  action     = "accept"
  schedule   = "always"
  logtraffic = "all"
  nat        = "disable"
  comments   = "Managed by Terraform: Palo Alto to Fortigate inside networks over IPv6 transport IPsec."

  srcintf {
    name = fortios_vpnipsec_phase1interface.palo_ipv6.name
  }

  dynamic "dstintf" {
    for_each = toset(var.inside_interfaces)
    content {
      name = dstintf.value
    }
  }

  dynamic "srcaddr" {
    for_each = fortios_firewall_address.palo_remote
    content {
      name = srcaddr.value.name
    }
  }

  dynamic "dstaddr" {
    for_each = fortios_firewall_address.fortigate_local
    content {
      name = dstaddr.value.name
    }
  }

  service {
    name = "ALL"
  }
}
