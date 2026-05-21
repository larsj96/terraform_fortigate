# Fortigate to Palo Alto IPv6 Site-to-Site VPN

This stack builds the Fortigate side of a route-based IKEv2/IPsec tunnel to the Palo Alto.

IPv6 is used only as the IKE/IPsec transport between the firewalls. The protected networks stay IPv4:

- Fortigate side: `10.0.0.0/16`
- Palo Alto side: `10.1.0.0/16`

The stack uses the newer `fortios_vpnipsec_phase1interface` and `fortios_vpnipsec_phase2interface` resources because the old root Fortigate stack is pinned to a provider version that does not expose IPv6 IPsec gateway fields cleanly.

Before applying, confirm both firewalls have global IPv6 addresses on their WAN interfaces and can ping each other over IPv6. `fe80::` link-local addresses are not enough.

## Run

```bash
cp backend.r2.tfbackend.example backend.r2.tfbackend
cp terraform.tfvars.example terraform.tfvars

terraform init -backend-config=backend.r2.tfbackend
terraform plan
```

Keep `terraform.tfvars`, `backend.r2.tfbackend`, state files, API tokens, and the pre-shared key out of git.
