
output "wan_ip" {
  # this is taking away the CIDR from the WAN_IP / this is used to feed data to external DNS: cloudfare
  value = split(" ", data.fortios_system_interface.wan_ip.ip)[0]
}

locals {
  wan_ipv6_candidates = compact(flatten([
    [
      for cfg in try(data.fortios_system_interface.wan_ip.ipv6, []) :
      try(split("/", cfg.ip6_address)[0], null)
      if try(cfg.ip6_address, "") != "" && !startswith(try(cfg.ip6_address, ""), "fe80:")
    ],
    [
      for cfg in try(data.fortios_system_interface.wan_ip.ipv6, []) :
      try(split("/", cfg.unique_autoconf_addr)[0], null)
      if try(cfg.unique_autoconf_addr, "") != "" && !startswith(try(cfg.unique_autoconf_addr, ""), "fe80:")
    ],
    flatten([
      for cfg in try(data.fortios_system_interface.wan_ip.ipv6, []) : [
        for extra in try(cfg.ip6_extra_addr, []) :
        try(split("/", extra.prefix)[0], null)
        if try(extra.prefix, "") != "" && !startswith(try(extra.prefix, ""), "fe80:")
      ]
    ])
  ]))
}

output "wan_ipv6" {
  description = "Global IPv6 address observed on the Fortigate WAN interface, used for Cloudflare AAAA/DDNS and IPv6 IPsec peers."
  value       = try(local.wan_ipv6_candidates[0], null)
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
