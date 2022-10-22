
locals {
  now = timestamp()

  OSLO_tz = timeadd(local.now, "2h") # OSLO official time (+ 0200 from UTC..?? ))

  date_oslo      = formatdate("YYYY-MM-DD hh:mm:ss", local.OSLO_tz)
  fortigate_time = formatdate("hh:mm:ss", local.OSLO_tz)

  date_utc = formatdate("YYYY-MM-DD", local.now)
}



output "test" {

  value = local.fortigate_time
}



resource "fortios_system_autoscript" "DateAndTime" {
  interval    = 120
  name        = "SET DATE AND TIME -"
  output_size = 10
  repeat      = 0

  script = <<EOF



#execute date "${formatdate("YYYY-MM-DD", "${timestamp()}")}"
#execute time "${local.fortigate_time}"

EOF
  start  = "auto"

}
