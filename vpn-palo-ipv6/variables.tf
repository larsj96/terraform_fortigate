variable "phase1_name" {
  description = "Fortigate route-based IPsec phase1/interface name."
  type        = string
  default     = "palo-ipv6"
}

variable "wan_interface" {
  description = "Fortigate WAN interface with Starlink IPv6."
  type        = string
  default     = "port9"
}

variable "fortigate_wan_ipv6" {
  description = "Fortigate global IPv6 address on the Starlink WAN. Null means FortiOS selects the interface IPv6."
  type        = string
  default     = null
  nullable    = true
}

variable "palo_peer_ipv6" {
  description = "Palo Alto global IPv6 address used as the IKE peer endpoint."
  type        = string
  default     = "2a0d:3341:bb9c:af01::443"
}

variable "local_id" {
  description = "IKE ID presented by the Fortigate."
  type        = string
  default     = "fortigate-mo-ipv6"
}

variable "palo_peer_id" {
  description = "IKE ID expected from the Palo Alto."
  type        = string
  default     = "pa510-homelab-ljn-ipv6"
}

variable "pre_shared_key" {
  description = "Pre-shared key for the Fortigate to Palo Alto IPv6 IPsec tunnel."
  type        = string
  sensitive   = true
}

variable "fortigate_local_subnets" {
  description = "IPv4 subnets behind the Fortigate side."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "palo_remote_subnets" {
  description = "IPv4 subnets behind the Palo Alto side."
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "fortigate_local_ipv6_subnets" {
  description = "Optional IPv6 selectors behind the Fortigate side. Keep empty until the Palo side can model matching IPv6 proxy IDs cleanly."
  type        = list(string)
  default     = []
}

variable "palo_remote_ipv6_subnets" {
  description = "Optional IPv6 selectors behind the Palo Alto side. Keep empty until routed inside IPv6 prefixes are defined."
  type        = list(string)
  default     = []
}

variable "inside_interfaces" {
  description = "Fortigate interfaces/VLANs allowed to use the Palo IPv6 tunnel."
  type        = list(string)
  default = [
    "k8s",
    "plex",
    "bastion",
    "vmware",
    "work",
    "idrac_Ilo",
  ]
}

variable "ike_proposal" {
  description = "Fortigate IKE phase1 proposal."
  type        = string
  default     = "aes256-sha256"
}

variable "ipsec_proposal" {
  description = "Fortigate IPsec phase2 proposal."
  type        = string
  default     = "aes256-sha256"
}

variable "dh_group" {
  description = "IKE/IPsec DH group."
  type        = string
  default     = "14"
}

variable "nat_traversal" {
  description = "Fortigate NAT traversal mode. Use forced for Starlink IPv6 testing so IPsec data is UDP-encapsulated instead of raw ESP."
  type        = string
  default     = "forced"

  validation {
    condition     = contains(["enable", "disable", "forced"], var.nat_traversal)
    error_message = "nat_traversal must be one of: enable, disable, forced."
  }
}

variable "route_distance" {
  description = "Static route distance for the direct Palo tunnel. Keep lower than the VPS fallback once fully validated."
  type        = number
  default     = 5
}
