
terraform {
  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = "1.16.0"
    }
  }

  backend "s3" {}
}


provider "fortios" {}




