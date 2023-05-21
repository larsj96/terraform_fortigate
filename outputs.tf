
output "wan_ip" {
  # this is taking away the CIDR from the WAN_IP / this is used to feed data to external DNS: cloudfare
  value = split(" ", data.fortios_system_interface.wan_ip.ip)[0]
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