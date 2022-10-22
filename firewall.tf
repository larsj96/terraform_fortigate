
# resource "fortios_firewall_address" "PREFIX_10-8" {
#   allow_routing = "disable"
#   name          = "PREFIX_10/8"
#   subnet        = "10.0.0.0 255.0.0.0"
#   type          = "ipmask"
#   visibility    = "enable"
# }

# resource "fortios_firewall_address" "PREFIX_172-16-12" {
#   allow_routing = "disable"
#   name          = "PREFIX_172.16/12"
#   subnet        = "172.16.0.0 255.240.0.0"
#   type          = "ipmask"
#   visibility    = "enable"
# }

# resource "fortios_firewall_address" "PREFIX_192-168-16" {
#   allow_routing = "disable"
#   name          = "PREFIX_192.168/16"
#   subnet        = "192.168.0.0 255.255.0.0"
#   type          = "ipmask"
#   visibility    = "enable"
# }

# resource "fortios_firewall_addrgrp" "rfc-1918" {
#   allow_routing = "disable"
#   color         = "26"
#   exclude       = "disable"
#   name          = "RFC_1918"
#   type          = "folder"
#   visibility    = "enable"

#   member { name = fortios_firewall_address.PREFIX_10-8.name }
#   member { name = fortios_firewall_address.PREFIX_172-16-12.name }
#   member { name = fortios_firewall_address.PREFIX_192-168-16.name }
# }


# resource "fortios_firewall_address" "test_from_tf_rest_api" {
# #  for_each = local.tf_ips.vcs

#   allow_routing        = "disable"
#   associated_interface = "port9"
#   color                = 3
#   name                 = "test_from_tf_rest_api"
#  subnet               = "${replace("${local.tf_ips.vcs[0]}", "/32", " ")}${cidrnetmask("52.86.200.106/32")}"
#  # subnet     = "${replace("${each.tf_ips.vcs[each.key]}", "/32", " ")}${cidrnetmask("52.86.200.106/32")}"
#   type       = "ipmask"
#   visibility = "enable"
# }