variable "r2_state_bucket" {
  description = "Cloudflare R2 bucket used for shared Terraform state."
  type        = string
  default     = "lanilsen-terraform-state"
}

variable "r2_endpoint" {
  description = "Cloudflare R2 S3 endpoint."
  type        = string
  default     = "https://10fe772bf2d6ab4c5ec76c0aceba8ae6.r2.cloudflarestorage.com"
}

variable "proxmox_state_key" {
  description = "R2 state key for terraform-proxmox/proxmox-core."
  type        = string
  default     = "terraform-proxmox/proxmox-core/terraform.tfstate"
}

variable "fortios_hostname" {
  description = "Fortigate API endpoint, for example https://10.0.0.33:444."
  type        = string
}

variable "fortios_access_token" {
  description = "Fortigate API token."
  type        = string
  sensitive   = true
}

variable "fortios_insecure" {
  description = "Skip Fortigate API TLS certificate verification."
  type        = bool
  default     = true
}

variable "mgmt_dns_zone" {
  description = "Fortigate authoritative DNS zone for homelab management records."
  type        = string
  default     = "mgmt.nilsen-tech.com"
}

variable "ilo_dns_zone" {
  description = "Fortigate authoritative DNS zone for out-of-band management records."
  type        = string
  default     = "ilo.nilsen-tech.com"
}

variable "dns_ttl" {
  description = "Default TTL for Fortigate DNS records."
  type        = number
  default     = 300
}

variable "extra_mgmt_records" {
  description = "Additional static records merged into the mgmt zone."
  type        = map(string)
  default     = {}
}

variable "extra_ilo_records" {
  description = "Additional static records merged into the iLO zone."
  type        = map(string)
  default     = {}
}

variable "recursive_dns_interfaces" {
  description = "Fortigate interfaces where the built-in DNS service should answer recursive queries for these zones."
  type        = list(string)
  default     = ["palo-ipv6", "to-hostinger"]
}

variable "enable_internal_tcp_vips" {
  description = "Create optional internal Fortigate TCP VIPs. Prefer reverse proxy for HTTPS host routing."
  type        = bool
  default     = false
}

variable "internal_tcp_vips" {
  description = "Optional internal TCP VIPs for simple port-forward use cases."
  type = map(object({
    comment     = optional(string, "")
    extintf     = string
    extip       = string
    extport     = number
    mapped_ip   = string
    mapped_port = number
  }))
  default = {}
}
