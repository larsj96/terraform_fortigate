# # https://docs.fortinet.com/document/fortigate/6.2.10/cookbook/277799/software-switch

# ##

# data "fortios_system_interfacelist" "ilo_idrac" {
#   filter = "alias=@IDRAC,alias=@ILO"
# }

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



# data "fortios_system_interfacelist" "switches" {
#   filter = "alias=@mikrotik,alias=@xyzel"
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

# }



# # This is setting the IP on the switch interface above ^^ - breaks whole terraform code.. 


# # resource "fortios_system_interface" "idrac_ilo_ip" {
# #   name                  = "idrac_Ilo"
# #   ip                    = "172.16.3.1 255.255.255.0"
# #  #ip                    = "0.0.0.0 0.0.0.0"

# #   device_identification = "enable"
# #   allowaccess           = "ping"
# #   mode                  = "static"
# #   type                  = "physical"
# #   vdom                  = "root"
# #   alias                 = "idrac_Ilo"

# #   depends_on = [
# #     fortios_system_interface.if
# #    ]


# #   lifecycle {
# #     create_before_destroy = true
# #   }

# # }
