
terraform {
  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = "1.16.0"
    }
  }

  cloud {
    organization = "lanilsen"

    workspaces {
      name = "fortigate"
    }
  }
}


provider "fortios" {}




