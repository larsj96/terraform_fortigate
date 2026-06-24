provider "fortios" {
  hostname = var.fortios_hostname
  username = var.fortios_username
  password = var.fortios_password
  token    = var.fortios_token
  insecure = var.fortios_insecure
  vdom     = var.vdom
}
