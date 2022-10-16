# resource "fortios_systemdhcp_server" "dhcp_idrac_ilo" {
#   dns_service     = "default"
#   fosid           = 1
#   interface       = fortios_system_switchinterface.idrac_ilo.id
#   netmask         = "255.255.255.0"
#   status          = "disable"
#   timezone        = "00"
#   default_gateway = "172.16.3.1"

#   ip_range {
#     end_ip   = "172.16.3.100"
#     id       = 1
#     start_ip = "172.16.3.2"
#   }

#   depends_on = [
#     fortios_system_switchinterface.idrac_ilo
#   ]
# }

# # resource "fortios_systemdhcp_server" "dhcp_all_subnets" {

# #   for_each = fortios_system_interface.vlan_cidr_calc

# #   dns_service = "default"

# #   # https://github.com/fortinetdev/terraform-provider-fortios/issues/221
# #   fosid = 0

# #   interface = each.value.id
# #   netmask   = split(" ", each.value.ip)[1]

# #   status   = "disable"
# #   timezone = "00"
# #   #default_gateway = cidrhost("${each.value.ip}", 1)
# #   # "${cidrhost("${each.value.cidr_block}", 1)}${" "}${cidrnetmask("${each.value.cidr_block}")}"
# #   #  default_gateway =  "${cidrhost("${each.value.ip}", 0)}${""}${cidrnetmask("${each.value.ip}")}"
# #   # ip_range {
# #   #   end_ip   = cidrhost("${each.value.ip}", 15)
# #   #   id       = 1
# #   #   start_ip = cidrhost("${each.value.ip}", 2)
# #   # }

# #   ip_range {
# #     end_ip   = split(" ", each.value.ip)[0]
# #     id       = 0
# #     start_ip = cidrhost("${split(" ", "${each.value.ip}" [0])}", 1)
# #   }
# # }
