resource "fortios_firewall_vip" "internal_tcp" {
  for_each = var.enable_internal_tcp_vips ? var.internal_tcp_vips : {}

  arp_reply                     = "enable"
  comment                       = each.value.comment
  extintf                       = each.value.extintf
  extip                         = each.value.extip
  extport                       = tostring(each.value.extport)
  ldb_method                    = "static"
  mappedport                    = tostring(each.value.mapped_port)
  max_embryonic_connections     = 1000
  name                          = each.key
  persistence                   = "none"
  portforward                   = "enable"
  portmapping_type              = "1-to-1"
  protocol                      = "tcp"
  ssl_server_session_state_type = "both"
  type                          = "static-nat"

  mappedip {
    range = each.value.mapped_ip
  }
}
