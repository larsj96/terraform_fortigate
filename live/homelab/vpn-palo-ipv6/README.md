# Fortigate to Palo Alto IPv6 Site-to-Site VPN

This stack builds the Fortigate side of a route-based IKEv2/IPsec tunnel to the Palo Alto.

IPv6 is used only as the IKE/IPsec transport between the firewalls. The protected networks stay IPv4:

- Fortigate side: `10.0.0.0/16`
- Palo Alto side: `10.1.0.0/16`

Routing preference:

```text
10.1.0.0/16 -> palo-ipv6 direct Palo Alto IPv6 IPsec, distance 5
10.1.0.0/16 -> to-hostinger Frankfurt VPS fallback, distance 50
10.8.0.0/24 -> to-hostinger Frankfurt VPS hub, distance 10
```

The direct IPv6 route must stay lower distance than the VPS fallback route. The fallback route exists on the Fortigate as route sequence `10` and is deliberately secondary.

NAT traversal is forced for the direct Starlink IPv6 tunnel. Without UDP encapsulation, IKE and the SA came up, but WSL/PC traffic had one-way data-plane symptoms: Palo encapsulated packets into `tunnel.20`, but no useful decap/return traffic was seen. After forcing NAT-T and committing Palo, WSL could reach Fortigate, Proxmox, and routed VMs over the direct tunnel.

The stack uses the newer `fortios_vpnipsec_phase1interface` and `fortios_vpnipsec_phase2interface` resources because the old root Fortigate stack is pinned to a provider version that does not expose IPv6 IPsec gateway fields cleanly.

Before applying, confirm both firewalls have global IPv6 addresses on their WAN interfaces and can ping each other over IPv6. `fe80::` link-local addresses are not enough.

## TCP MSS Clamp

The IPv6 Starlink site-to-site tunnel carries IPv4 LAN traffic inside IPsec/NAT-T. That path has enough encapsulation overhead and jitter that normal TCP sessions can collapse into tiny congestion windows even while ping and UDP tests look acceptable.

This stack clamps TCP MSS on both Fortigate firewall policies with `vpn_tcp_mss`, defaulting to `1300`:

```hcl
vpn_tcp_mss = 1300
```

Keep this enabled for Plex and other long-lived TCP streams across the Palo Alto to Fortigate tunnel. If tests still show retransmits, test `1280`; if the path becomes clean and stable, `1360` can be tested later.

## Run

```bash
cp backend.r2.tfbackend.example backend.r2.tfbackend
cp terraform.tfvars.example terraform.tfvars

terraform init -backend-config=backend.r2.tfbackend
terraform plan
```

Keep `terraform.tfvars`, `backend.r2.tfbackend`, state files, API tokens, and the pre-shared key out of git.
