data "terraform_remote_state" "proxmox_core" {
  backend = "s3"

  config = {
    bucket                      = var.r2_state_bucket
    key                         = var.proxmox_state_key
    region                      = "auto"
    endpoints                   = { s3 = var.r2_endpoint }
    use_lockfile                = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
}

locals {
  proxmox_mgmt_records = try(data.terraform_remote_state.proxmox_core.outputs.mgmt_dns_records, {})
  proxmox_ilo_records  = try(data.terraform_remote_state.proxmox_core.outputs.ilo_dns_records, {})

  # Friendly aliases that should follow Terraform-created VM addresses.
  # These keep user-facing names stable even when the VM resource name is less public.
  default_mgmt_alias_records = {
    plex1 = try(local.proxmox_mgmt_records.media1, "10.0.0.39")
    media = try(local.proxmox_mgmt_records.media1, "10.0.0.39")
  }

  default_ilo_records = {
    hp1   = "10.0.124.164"
    hp2   = "10.0.124.165"
    hp3   = "10.0.124.163"
    dell1 = "10.0.124.162"
  }

  mgmt_records = merge(local.proxmox_mgmt_records, local.default_mgmt_alias_records, var.extra_mgmt_records)
  ilo_records  = merge(local.default_ilo_records, local.proxmox_ilo_records, var.extra_ilo_records)
}
