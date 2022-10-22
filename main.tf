
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




    
