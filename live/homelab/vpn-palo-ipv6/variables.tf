variable "fortios_hostname" {
  description = "Fortigate API hostname or URL."
  type        = string
}

variable "fortios_username" {
  description = "Fortigate API username. Optional when fortios_token is used."
  type        = string
  default     = null
  nullable    = true
}

variable "fortios_password" {
  description = "Fortigate API password. Optional when fortios_token is used."
  type        = string
  sensitive   = true
  default     = null
  nullable    = true
}

variable "fortios_token" {
  description = "Fortigate API token. Prefer this over username/password."
  type        = string
  sensitive   = true
  default     = null
  nullable    = true
}

variable "fortios_insecure" {
  description = "Skip Fortigate API TLS verification."
  type        = bool
  default     = true
}

variable "vdom" {
  description = "Fortigate VDOM."
  type        = string
  default     = "root"
}

variable "tunnel_name" {
  description = "Fortigate IPsec interface/phase1 name."
  type        = string
  default     = "palo-ipv6-s2s"
}

variable "wan_interface" {
  description = "Fortigate WAN interface with global IPv6 connectivity."
  type        = string
  default     = "wan"
}

variable "fortigate_wan_ipv6" {
  description = "Optional global IPv6 address on the Fortigate WAN. Leave null to let Fortigate choose the outgoing source."
  type        = string
  default     = null
  nullable    = true
}

variable "palo_peer_ipv6" {
  description = "Global IPv6 address of the Palo Alto WAN interface. Must not be fe80:: link-local."
  type        = string
}

variable "fortigate_local_id" {
  description = "IKE local identity presented by the Fortigate."
  type        = string
  default     = "fortigate-mo-ipv6"
}

variable "palo_peer_id" {
  description = "IKE peer identity expected from the Palo Alto."
  type        = string
  default     = "pa510-homelab-ljn-ipv6"
}

variable "pre_shared_key" {
  description = "Pre-shared key for the Fortigate to Palo Alto IPv6 IPSec tunnel."
  type        = string
  sensitive   = true
}

variable "local_subnets" {
  description = "Local IPv4 subnets behind the Fortigate."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "remote_subnets" {
  description = "Remote IPv4 subnets behind the Palo Alto."
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "source_interfaces" {
  description = "Fortigate interfaces/zones allowed to reach the Palo Alto side."
  type        = list(string)
  default     = ["any"]
}

variable "ike_proposal" {
  description = "Fortigate phase1 proposal."
  type        = string
  default     = "aes256-sha256"
}

variable "ipsec_proposal" {
  description = "Fortigate phase2 proposal."
  type        = string
  default     = "aes256-sha256"
}

variable "dh_groups" {
  description = "Fortigate Diffie-Hellman groups."
  type        = string
  default     = "14"
}

variable "nat_traversal" {
  description = "Fortigate NAT traversal mode. Use forced for Starlink IPv6 so IPsec data is UDP-encapsulated instead of raw ESP."
  type        = string
  default     = "forced"

  validation {
    condition     = contains(["enable", "disable", "forced"], var.nat_traversal)
    error_message = "nat_traversal must be one of: enable, disable, forced."
  }
}

variable "phase1_keylife_seconds" {
  description = "IKE phase1 key lifetime in seconds."
  type        = number
  default     = 28800
}

variable "phase2_keylife_seconds" {
  description = "IPsec phase2 key lifetime in seconds."
  type        = number
  default     = 3600
}

variable "route_distance" {
  description = "Static route distance for remote Palo Alto subnets over the direct IPv6 tunnel. Keep lower than the VPS fallback route."
  type        = number
  default     = 5
}

variable "vpn_tcp_mss" {
  description = "TCP MSS clamp for traffic crossing the IPv6 IPsec tunnel. Keep below the effective Starlink/NAT-T/IPsec path MTU to avoid TCP retransmits."
  type        = number
  default     = 1300
  nullable    = true
}
