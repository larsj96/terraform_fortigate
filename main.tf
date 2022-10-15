
terraform {
  required_providers {
    fortios = {
      source = "fortinetdev/fortios"
    }

  }
  cloud {
    organization = "lanilsen"

    workspaces {
      name = "Homelabb-Fortigate"
    }
  }
}


# works OK - delete switchinterfaces if issue like below and rerun apply / destroy

# 
#  Error: Error deleting SystemInterface resource: Internal Server Error - Internal error when processing the request (500)
#  Cli response:
#  change table entry idrac_Ilo
#  Can not delete a static table entry
#  Command fail. Return code -61
#  cmd_clean_context 0, abort=1

