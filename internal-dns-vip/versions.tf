terraform {
  required_version = ">= 1.10.0"

  backend "s3" {}

  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = "1.16.0"
    }
  }
}

provider "fortios" {
  hostname = var.fortios_hostname
  token    = var.fortios_access_token
  insecure = var.fortios_insecure
}
