
# # Old way to set VLAN - fortios_networking_interface_port is EOL and might not work in future terraform version
# resource "fortios_networking_interface_port" "vlan" {
#   for_each = var.vlan_interfaces

#   vlanid                = tostring(each.value.vlan)
#   ip                    = each.value.ip
#   mode                  = lookup(each.value, "mode", "static")
#   type                  = lookup(each.value, "type", "vlan")
#   vdom                  = "root"
#   alias                 = each.key
#   name                  = each.key
#   description           = "Created by Terraform"
#   interface             = each.value.interface
#   device_identification = each.value.device_identification
#   allowaccess           = each.value.allowaccess

#   depends_on = [
#     data.fortios_system_interfacelist.switches
#   ]
# }


locals {
  # If we allocate two addressing bits to regions and
  # three addressing bits to subnett then we can have
  # up to four regions and up to eight subnett, with
  # each zone then requiring five subnet addressing
  # bits in total.
  regions = {
    fortigate_onprem_ = 0
    azure_north_eu_   = 1
    # number 3 available for future expansion
  }
  subnett = {
    k8s     = 1
    plex    = 2
    bastion = 3
    gitlab  = 4
    vmware  = 5

  }

  base_cidr_block = "10.0.0.0/16"
  region_blocks = {
    for name, num in local.regions : name => {
      cidr_block = cidrsubnet(local.base_cidr_block, 4, num)
    }
  }
  subnetts_block = {
    for name, region_num in local.regions : name => {
      for letter, num in local.subnett : "${name}${letter}" => {
        cidr_block = cidrsubnet(local.region_blocks[name].cidr_block, 7, num)
        vlanid     = "${01}${num + 1}"
      }
    }
  }


}





output "networks" {
  value = {
    networks = {
      cidr_block = local.base_cidr_block
      regions    = local.region_blocks
      subnets    = local.subnetts_block
    }
  }
}


resource "fortios_system_interface" "vlan_cidr_calc" {
  for_each = local.subnetts_block.fortigate_onprem_

  defaultgw = "enable"
  ip        = "${cidrhost("${each.value.cidr_block}", 1)}${" "}${cidrnetmask("${each.value.cidr_block}")}"

  vlanid = each.value.vlanid

  name        = replace("${each.key}", "fortigate_onprem_", "")
  type        = "vlan"
  vdom        = "root"
  mode        = "static"
  description = "Created by Terraform Provider for FortiOS"

  interface             = "switches"
  device_identification = "enable"
}
