resource "fortios_system_dnsserver" "recursive" {
  for_each = toset(var.recursive_dns_interfaces)

  name = each.value
  mode = "recursive"
}
