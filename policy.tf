# resource "fortios_firewall_policy" "wifi_idrac_ilo" {
#   action     = "accept"
#   logtraffic = "all"
#   name       = "wifi - idrac_ilo"
#   schedule   = "always"
#   nat        = "enable"

#   dstaddr {
#     name = "all"
#   }

#   dstintf {
#     name = "idrac_Ilo"
#   }

#   service {
#     name = "ALL"
#   }

#   srcaddr {
#     name = "all"
#   }

#   srcintf {
#     name = "R21B_Wifi"
#   }
# }

# resource "fortios_firewall_policy" "wifi_esxi_mgmt" {
#   action     = "accept"
#   logtraffic = "all"
#   name       = "wifi_esxi_mgmt"
#   schedule   = "always"
#   nat        = "enable"

#   dstaddr {
#     name = "all"
#   }

#   dstintf {
#     name = fortios_networking_interface_port.vlan["esxi_mgmt"].name
#   }

#   service {
#     name = "ALL"
#   }

#   srcaddr {
#     name = "all"
#   }

#   srcintf {
#     name = "R21B_Wifi"
#   }
# }



# resource "fortios_firewall_policy" "wifi_switch" {
#   action     = "accept"
#   logtraffic = "all"
#   name       = "wifi_switch"
#   schedule   = "always"
#   nat        = "enable"

#   dstaddr {
#     name = "all"
#   }

#   dstintf {
#     name = fortios_system_switchinterface.switches.name
#   }

#   service {
#     name = "ALL"
#   }

#   srcaddr {
#     name = "all"
#   }

#   srcintf {
#     name = "R21B_Wifi"
#   }
# }


# # resource "fortios_firewall_policy" "wifi_bastion" {
# #   action     = "accept"
# #   logtraffic = "all"
# #   name       = "wifi_bastion"
# #   schedule   = "always"
# #   nat        = "enable"

# #   dstaddr {
# #     name = "all"
# #   }

# #   dstintf {
# #     name = fortios_networking_interface_port.vlan["bastionz"].name
# #   }

# #   service {
# #     name = "ALL"
# #   }

# #   srcaddr {
# #     name = "all"
# #   }

# #   srcintf {
# #     name = "R21B_Wifi"
# #   }
# # }





# # data "fortios_system_interfacelist" "vlan_interfaces" {
# #   filter = "type=@vlan"

# #   depends_on = [
# #     fortios_networking_interface_port.vlan
# #   ]
# # }

# #  output vlans {
# #    value =  fortios_networking_interface_port.vlan
# #  }

# # resource "fortios_firewall_policy" "bastion_til_alt" {
# #   action     = "accept"
# #   logtraffic = "all"
# #   name       = "bastion --> *"
# #   schedule   = "always"
# #   nat        = "enable"

# #   dstaddr {
# #     name = "all"
# #   }

# #   # building dstintf bloc
# #   dynamic "dstintf" {
# #     for_each = fortios_networking_interface_port.vlan
# #     content {
# #       name = dstintf.value.id
# #     }
# #   }
# #   service {
# #     name = "ALL"
# #   }
# #   srcaddr {
# #     name = "all"
# #   }
# #   srcintf {
# #     name = fortios_networking_interface_port.vlan["bastionz"].name
# #   }
# # }

# resource "fortios_firewall_policy" "alt_til_wan" {
#   action     = "accept"
#   logtraffic = "all"
#   name       = " * --> WAN "
#   schedule   = "always"
#   nat        = "enable"

#   dstaddr {
#     name = "all"
#   }

#   dstintf {
#     name = "port9"
#   }

#   service {
#     name = "ALL"
#   }
#   srcaddr {
#     name = "all"
#   }
#   dynamic "srcintf" {
#     for_each = fortios_networking_interface_port.vlan
#     content {
#       name = srcintf.value.id
#     }
#   }
# }

# # resource "fortios_firewall_policy" "alt_til_filz_smb" {
# #   action     = "accept"
# #   logtraffic = "all"
# #   name       = "* --> filz TCP 445 - SMB"
# #   schedule   = "always"
# #   nat        = "enable"

# #   dstaddr {
# #     name = "all"
# #   }

# #   dstintf {
# #     name = fortios_networking_interface_port.vlan["filz"].name
# #   }

# #   service {
# #     name = "SMB"
# #   }
# #   srcaddr {
# #     name = "all"
# #   }
# #   dynamic "srcintf" {
# #     for_each = fortios_networking_interface_port.vlan
# #     content {
# #       name = srcintf.value.id
# #     }
# #   }
# # }

# # resource "fortios_firewall_policy" "alt_til_filz_nfs" {
# #   action     = "accept"
# #   logtraffic = "all"
# #   name       = "* --> filz  - NFS"
# #   schedule   = "always"
# #   nat        = "enable"

# #   dstaddr {
# #     name = "all"
# #   }

# #   dstintf {
# #     name = fortios_networking_interface_port.vlan["filz"].name
# #   }

# #   service {
# #     name = "NFS"
# #   }
# #   srcaddr {
# #     name = "all"
# #   }
# #   dynamic "srcintf" {
# #     for_each = fortios_networking_interface_port.vlan
# #     content {
# #       name = srcintf.value.id
# #     }
# #   }
# # }




# # resource "fortios_firewall_policy" "alt_til_adz_dns" {
# #   action     = "accept"
# #   logtraffic = "all"
# #   name       = "* --> adz  - DNS"
# #   schedule   = "always"
# #   nat        = "enable"

# #   dstaddr {
# #     name = "all"
# #   }

# #   dstintf {
# #     name = fortios_networking_interface_port.vlan["adz"].name
# #   }

# #   service {
# #     name = "DNS"
# #   }
# #   srcaddr {
# #     name = "all"
# #   }
# #   dynamic "srcintf" {
# #     for_each = fortios_networking_interface_port.vlan
# #     content {
# #       name = srcintf.value.id
# #     }
# #   }
# # }



# # resource "fortios_firewallservice_custom" "sonarr_radarr_jackett" {
# #   app_service_type    = "disable"
# #   category            = "General"
# #   check_reset_range   = "default"
# #   color               = 0
# #   helper              = "auto"
# #   iprange             = "0.0.0.0"
# #   name                = "sonarr_radarr_jackett"
# #   protocol            = "TCP"
# #   protocol_number     = 6
# #   proxy               = "disable"
# #   tcp_halfclose_timer = 0
# #   tcp_halfopen_timer  = 0
# #   tcp_portrange       = "7878-9999"
# #   tcp_timewait_timer  = 0
# #   udp_idle_timer      = 0
# #   visibility          = "enable"
# # }


# resource "fortios_firewallservice_custom" "influxdb" {
#   app_service_type    = "disable"
#   category            = "General"
#   check_reset_range   = "default"
#   color               = 0
#   helper              = "auto"
#   iprange             = "0.0.0.0"
#   name                = "influxdb"
#   protocol            = "TCP"
#   protocol_number     = 6
#   proxy               = "disable"
#   tcp_halfclose_timer = 0
#   tcp_halfopen_timer  = 0
#   tcp_portrange       = "8086-8086"
#   tcp_timewait_timer  = 0
#   udp_idle_timer      = 0
#   visibility          = "enable"
# }

# resource "fortios_firewall_policy" "alt_til_influxdbz" {
#   action     = "accept"
#   logtraffic = "all"
#   name       = "* --> influxdbz 8086"
#   schedule   = "always"
#   nat        = "enable"

#   dstaddr {
#     name = "all"
#   }

#   dstintf {
#     name = fortios_system_interface.vlan_cidr_calc["fortigate_onprem_k8s"].name
#   }

#   service {
#     name = fortios_firewallservice_custom.influxdb.name
#   }

#   srcaddr {
#     name = "all"
#   }

#   dynamic "srcintf" {
#     for_each = fortios_system_interface.vlan_cidr_calc
#     content {
#       name = srcintf.value.id
#     }
#   }
# }

# resource "fortios_firewall_policy" "alt_til_alt_icmp" {
#   action     = "accept"
#   logtraffic = "all"
#   name       = "* --> *  - ICMP"
#   schedule   = "always"
#   nat        = "enable"

#   dstaddr {
#     name = "all"
#   }

#   dynamic "dstintf" {
#     for_each = fortios_system_interface.vlan_cidr_calc
    
#     content {
#       name = dstintf.value.id
#     }
#   }

#   service {
#     name = "ALL_ICMP"
#   }
#   srcaddr {
#     name = "all"
#   }
#   dynamic "srcintf" {
#     for_each = fortios_system_interface.vlan_cidr_calc
#     content {
#       name = srcintf.value.id
#     }
#   }
# }

