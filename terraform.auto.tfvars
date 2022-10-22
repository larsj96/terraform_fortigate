# hostname = "10.0.0.97:444"

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


# # http://blog.itsjustcode.net/blog/2017/11/18/terraform-cidrsubnet-deconstructed/





