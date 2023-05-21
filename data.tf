
data "fortios_system_interfacelist" "ilo_idrac" {
  filter = "alias=@IDRAC,alias=@ILO"
}


data "fortios_system_interfacelist" "switches" {
  filter = "alias=@mikrotik,alias=@xyzel"
}

# data "terraform_remote_state" "vmware_vm" {
#   backend = "http"

#   config = {                                                              # this is the state for VMWARE_VM project
#     address  = "http://10.0.0.130/api/v4/projects/3/terraform/state/main" # EXPORT TF_HTTP_ADDRESS env variable otherwise hardcode it here :-)
#     username = "terraform"
#     # password = "XXXXXXXX"
#   }
# }

# locals {
#   vmware_vm_Ips = data.terraform_remote_state.vmware_vm.outputs.all_ips
# }

# output "vmware_vm_Ips" {
#   value = local.vmware_vm_Ips
# }

data "fortios_system_interface" "wan_ip" {
  # WAN INTERFACE!
  name = "port9"
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




