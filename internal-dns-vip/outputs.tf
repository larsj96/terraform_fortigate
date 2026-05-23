output "mgmt_records" {
  description = "Management records written to Fortigate DNS."
  value       = local.mgmt_records
}

output "ilo_records" {
  description = "iLO/iDRAC records written to Fortigate DNS."
  value       = local.ilo_records
}

output "internal_tcp_vips" {
  description = "Optional internal TCP VIP names."
  value       = keys(fortios_firewall_vip.internal_tcp)
}

output "recursive_dns_interfaces" {
  description = "Interfaces where Fortigate DNS recursive service is enabled by this stack."
  value       = sort(keys(fortios_system_dnsserver.recursive))
}
