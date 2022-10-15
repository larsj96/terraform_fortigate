hostname = "192.168.13.1:444"

system_interfaces = {
  HP1_ILO = {
    "portnumber"            = 10
    "ip"                    = "0.0.0.0 0.0.0.0"
    "device_identification" = "enable"
    "allowaccess"           = "ping"
    "mode"                  = "static"
    "type"                  = "physical"
  }
  HP2_ILO = {
    "portnumber"            = 13
    "ip"                    = "0.0.0.0 0.0.0.0"
    "device_identification" = "enable"
    "allowaccess"           = "ping"
    "mode"                  = "static"
    "type"                  = "physical"
  }
  HP3_ILO = {
    "portnumber"            = 12
    "ip"                    = "0.0.0.0 0.0.0.0"
    "device_identification" = "enable"
    "allowaccess"           = "ping"
    "mode"                  = "static"
    "type"                  = "physical"
  }
  DELL1_IDRAC = {
    "portnumber"            = 14
    "ip"                    = "0.0.0.0 0.0.0.0"
    "device_identification" = "enable"
    "allowaccess"           = "ping"
    "mode"                  = "static"
    "type"                  = "physical"
  }

  mikrotik_switch = {
    "portnumber"            = 11
    "ip"                    = "0.0.0.0 0.0.0.0"
    "device_identification" = "enable"
    "allowaccess"           = "ping"
    "mode"                  = "static"
    "type"                  = "physical"
  }

  xyzel_switch = {
    "portnumber"            = 16
    "ip"                    = "0.0.0.0 0.0.0.0"
    "device_identification" = "enable"
    "allowaccess"           = "ping"
    "mode"                  = "static"
    "type"                  = "physical"
  }
}


# http://blog.itsjustcode.net/blog/2017/11/18/terraform-cidrsubnet-deconstructed/


# Manhandled vlan interface without cidr calc function - shold be quite standalone :-)
vlan_interfaces = {
  esxi_mgmt = {
    "vlan"                  = "2"
    "interface"             = "switches"
    "ip"                    = "10.1.1.1/28"
    "device_identification" = "enable"
    "allowaccess"           = "ping"
  }

  bastionz_mgmt = {
    "vlan"                  = "3"
    "interface"             = "switches"
    "ip"                    = "10.1.1.17/28"
    "device_identification" = "enable"
    "allowaccess"           = "ping https http"
  }


}


