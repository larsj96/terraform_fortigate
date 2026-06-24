output "vpn_summary" {
  description = "Summary of the Fortigate to Palo Alto IPv6 site-to-site VPN intent."
  value = {
    tunnel_name       = fortios_vpnipsec_phase1interface.palo.name
    wan_interface     = var.wan_interface
    palo_peer_ipv6    = var.palo_peer_ipv6
    local_id          = var.fortigate_local_id
    peer_id           = var.palo_peer_id
    local_subnets     = var.local_subnets
    remote_subnets    = var.remote_subnets
    source_interfaces = var.source_interfaces
  }
}
