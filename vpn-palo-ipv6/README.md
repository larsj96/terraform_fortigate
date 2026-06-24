# Fortigate to Palo Alto IPv6 Site-to-Site VPN

This stack manages the Fortigate side of the direct Mo i Rana to cabin VPN.

IPv6 is the transport only:

- Fortigate endpoint: Starlink WAN `port9`
- Palo endpoint: Palo Alto `loopback.12`, currently `2a0d:3341:bb9c:af01::443`
- Protected Fortigate IPv4 network: `10.0.0.0/16`
- Protected Palo Alto IPv4 network: `10.1.0.0/16`

Routing preference:

```text
10.1.0.0/16 -> palo-ipv6 direct Palo Alto IPv6 IPsec, distance 5
10.1.0.0/16 -> to-hostinger Frankfurt VPS fallback, distance 50
10.8.0.0/24 -> to-hostinger Frankfurt VPS hub, distance 10
```

The direct route is managed by this stack through `fortios_router_static.to_palo`. The legacy VPS fallback route currently exists on the Fortigate as route sequence `10`; keep its distance higher than the direct route so the VPS is secondary.

NAT traversal is set to `forced` for this direct Starlink IPv6 tunnel. IKE can establish with raw ESP, but WSL/PC testing showed one-way data-plane symptoms. UDP encapsulation gives the tunnel a better chance across the Starlink access network.

The Fortigate WAN must use SLAAC on Starlink. On `2026-05-23`, `port9` was changed from DHCPv6 IANA-only to SLAAC/autoconf and received:

```text
2a0d:3341:bb00:6320:a5b:eff:feca:b2e9/64
```

FortiGate handles dual-stack phase2 selectors differently from Palo Alto. If
we later route IPv6 networks inside the tunnel, FortiGate should have a
separate IPv6 phase2 selector. This stack can create:

- IPv4 phase2 selectors for `fortigate_local_subnets` to `palo_remote_subnets`.
- Optional IPv6 phase2 selectors for `fortigate_local_ipv6_subnets` to `palo_remote_ipv6_subnets`.

For now those IPv6 selector lists default to empty because the PAN-OS Terraform
provider accepts only IPv4 addresses in the `proxy_id` block. The current live
goal is IPv4 protected networks over IPv6 transport.

Keep `terraform.tfvars`, backend config, state files, and PSKs out of git.

```bash
cp backend.r2.tfbackend.example backend.r2.tfbackend
cp terraform.tfvars.example terraform.tfvars
export FORTIOS_ACCESS_HOSTNAME="10.0.0.33:444"
export FORTIOS_ACCESS_TOKEN="..."
export FORTIOS_INSECURE="true"
export TF_VAR_pre_shared_key="..."
terraform init -backend-config=backend.r2.tfbackend
terraform plan
```
