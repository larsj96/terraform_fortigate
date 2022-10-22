
data "fortios_system_interfacelist" "ilo_idrac" {
  filter = "alias=@IDRAC,alias=@ILO"
}


data "fortios_system_interfacelist" "switches" {
  filter = "alias=@mikrotik,alias=@xyzel"
}



# data "http" "terraform_cloud" {
#   url = "https://app.terraform.io/api/meta/ip-ranges"

#   # Optional request headers
#   request_headers = {
#     Accept = "application/json"
#   }
# }


# # This is fetching the IP Range from Terraform cloud - so we can use it towards the fortigate / vmware +++
# locals {
#   tf_ips = jsondecode("${data.http.terraform_cloud.body}")
# }


# output "tf_ips" {
#   value = local.tf_ips
# }




