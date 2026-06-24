locals {
  local_address_objects = {
    for subnet in var.local_subnets :
    format("vpn-local-%s", replace(replace(subnet, "/", "-"), ".", "-")) => {
      cidr = subnet
      mask = format("%s %s", cidrhost(subnet, 0), cidrnetmask(subnet))
    }
  }

  remote_address_objects = {
    for subnet in var.remote_subnets :
    format("vpn-palo-%s", replace(replace(subnet, "/", "-"), ".", "-")) => {
      cidr = subnet
      mask = format("%s %s", cidrhost(subnet, 0), cidrnetmask(subnet))
    }
  }

  phase2_pairs = {
    for pair in flatten([
      for local_name, local_obj in local.local_address_objects : [
        for remote_name, remote_obj in local.remote_address_objects : {
          name        = format("p2-%s-to-%s", replace(local_name, "vpn-local-", ""), replace(remote_name, "vpn-palo-", ""))
          local_cidr  = local_obj.cidr
          local_mask  = local_obj.mask
          remote_cidr = remote_obj.cidr
          remote_mask = remote_obj.mask
        }
      ]
    ]) : pair.name => pair
  }
}
