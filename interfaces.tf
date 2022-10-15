resource "fortios_system_interface" "if" {
  for_each = var.system_interfaces

  name = "port${tostring(each.value.portnumber)}"
  ip   = each.value.ip

  mode        = each.value.mode
  type        = each.value.type
  vdom        = "root"
  alias       = each.key
  description = "Created by Terraform"

}


