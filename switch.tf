# # https://docs.fortinet.com/document/fortigate/6.2.10/cookbook/277799/software-switch

# ##


# resource "fortios_system_switchinterface" "idrac_ilo" {
#   name = "idrac_Ilo"
#   vdom = "root"
#   type = "switch"

#   dynamic "member" {
#     for_each = data.fortios_system_interfacelist.ilo_idrac.namelist

#     content {
#       interface_name = member.value
#     }
#   }
# }


# resource "fortios_system_switchinterface" "switches" {
#   name = "switches"
#   vdom = "root"
#   type = "switch"

#   dynamic "member" {
#     for_each = data.fortios_system_interfacelist.switches.namelist

#     content {
#       interface_name = member.value
#     }
#   }

#   depends_on = [
#     fortios_system_interface.if
#    ]

#  }