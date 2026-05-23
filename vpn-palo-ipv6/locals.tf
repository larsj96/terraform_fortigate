locals {
  fortigate_local_subnet_masks = {
    for subnet in var.fortigate_local_subnets :
    subnet => format("%s %s", split("/", subnet)[0], cidrnetmask(subnet))
  }

  palo_remote_subnet_masks = {
    for subnet in var.palo_remote_subnets :
    subnet => format("%s %s", split("/", subnet)[0], cidrnetmask(subnet))
  }

  phase2_ipv4_pairs = flatten([
    for local_subnet in var.fortigate_local_subnets : [
      for remote_subnet in var.palo_remote_subnets : {
        name = format(
          "p2-v4-%s-to-%s",
          replace(replace(local_subnet, "/", "-"), ".", "-"),
          replace(replace(remote_subnet, "/", "-"), ".", "-")
        )
        src = local.fortigate_local_subnet_masks[local_subnet]
        dst = local.palo_remote_subnet_masks[remote_subnet]
      }
    ]
  ])

  phase2_ipv6_pairs = flatten([
    for local_subnet in var.fortigate_local_ipv6_subnets : [
      for remote_subnet in var.palo_remote_ipv6_subnets : {
        name = format(
          "p2-v6-%s-to-%s",
          replace(replace(replace(local_subnet, "/", "-"), ":", "-"), ".", "-"),
          replace(replace(replace(remote_subnet, "/", "-"), ":", "-"), ".", "-")
        )
        src = local_subnet
        dst = remote_subnet
      }
    ]
  ])

  route_map = {
    for subnet in var.palo_remote_subnets :
    replace(replace(subnet, "/", "-"), ".", "-") => subnet
  }
}
