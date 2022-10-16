
terraform {
  required_providers {
    fortios = {
      source = "fortinetdev/fortios"
      version = "1.16.0"
    }
  }

  backend "http" {
  }

}

provider "fortios" {
}

resource "fortios_system_setting_dns" "dns" {
  primary   = "1.1.1.1"
  secondary = "1.1.2.2"
}


