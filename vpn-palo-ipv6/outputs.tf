output "vpn_summary" {
  description = "Summary of Fortigate side Palo IPv6 VPN."
  value = {
    phase1              = fortios_vpnipsec_phase1interface.palo_ipv6.name
    wan_interface       = var.wan_interface
    fortigate_wan_ipv6  = var.fortigate_wan_ipv6
    palo_peer_ipv6      = var.palo_peer_ipv6
    local_subnets       = var.fortigate_local_subnets
    remote_subnets      = var.palo_remote_subnets
    local_ipv6_subnets  = var.fortigate_local_ipv6_subnets
    remote_ipv6_subnets = var.palo_remote_ipv6_subnets
    inside_interfaces   = var.inside_interfaces
  }
}
