# Fortigate Internal DNS And VIPs

Isolated Terraform stack for homelab DNS records and optional internal TCP VIPs.

This stack intentionally lives outside the existing Fortigate root stack so it can be tested without disturbing current interface, VLAN, policy, and legacy DNS resources.

## What It Manages

- `mgmt.nilsen-tech.com` authoritative DNS database.
- `ilo.nilsen-tech.com` authoritative DNS database.
- Records are read from `terraform-proxmox/proxmox-core` remote state in Cloudflare R2.
- Recursive DNS listener entries for the Palo/Fortigate and VPS/Fortigate tunnel interfaces.
- Optional simple TCP VIPs for cases where a port-forward is genuinely useful.

## Remote State Flow

```text
terraform-proxmox/proxmox-core
  -> outputs mgmt_dns_records and ilo_dns_records
  -> Cloudflare R2 state
  -> terraform-fortigate/internal-dns-vip
  -> Fortigate DNS databases
```

## Expected Records

The Proxmox stack currently exports records like:

```text
mgmt1.mgmt.nilsen-tech.com      -> 10.0.0.100
code.mgmt.nilsen-tech.com       -> 10.0.0.100
runner1.mgmt.nilsen-tech.com    -> 10.0.0.101
bastion1.mgmt.nilsen-tech.com   -> 10.0.0.99
proxmox1.mgmt.nilsen-tech.com   -> 10.0.0.162
docs.mgmt.nilsen-tech.com       -> 10.0.0.37
grafana.mgmt.nilsen-tech.com    -> 10.0.0.38
media1.mgmt.nilsen-tech.com     -> 10.0.0.39
plex1.mgmt.nilsen-tech.com      -> 10.0.0.39
media.mgmt.nilsen-tech.com      -> 10.0.0.39

hp1.ilo.nilsen-tech.com         -> 10.0.124.164
hp2.ilo.nilsen-tech.com         -> 10.0.124.165
hp3.ilo.nilsen-tech.com         -> 10.0.124.163
dell1.ilo.nilsen-tech.com       -> 10.0.124.162
```

`plex1` and `media` are friendly aliases layered on top of the Proxmox output named `media1`. They keep user-facing names stable while Terraform can still name the VM/resource after its broader media role.

## Split DNS Consumers

The Fortigate should remain authoritative for the internal zones:

```text
mgmt.nilsen-tech.com
ilo.nilsen-tech.com
```

Palo Alto and GlobalProtect should not recreate these records. Instead, use DNS proxy/conditional forwarding on the Palo Alto side so these zones are forwarded across the Palo-to-Fortigate tunnel to the Fortigate resolver on `10.0.0.33`.

This stack enables the Fortigate DNS service on:

```text
palo-ipv6
to-hostinger
```

That lets queries arriving over the direct IPv6 site-to-site tunnel and the Frankfurt VPS fallback tunnel use the same Fortigate zones.

Expected examples:

```text
hp1.ilo.nilsen-tech.com       -> 10.0.124.164
plex1.mgmt.nilsen-tech.com    -> 10.0.0.39
grafana.mgmt.nilsen-tech.com  -> 10.0.0.38
```

External names under `lanilsen.com` stay in Cloudflare and point at Cloudflare Tunnel or future public reverse-proxy entry points:

```text
docs.lanilsen.com
grafana.lanilsen.com
auth.lanilsen.com
plex1.lanilsen.com
```

## Backend

```bash
cp backend.r2.tfbackend.example backend.r2.tfbackend
terraform init -backend-config=backend.r2.tfbackend
```

Keep `backend.r2.tfbackend` ignored and outside git.

## Provider Secrets

Keep Fortigate API access outside git:

```bash
export TF_VAR_fortios_hostname="https://10.0.0.33:444"
export TF_VAR_fortios_access_token="..."
export TF_VAR_fortios_insecure=true
```

On the Frankfurt VPS these values should live in:

```text
/root/.config/homelab/fortigate.env
```

## SSL And No-Port URLs

Do not make Fortigate VIPs the default SSL termination point for internal apps.

Preferred model:

```text
Fortigate DNS -> internal reverse proxy -> app container/VM
Cloudflare DNS-01 -> Let's Encrypt certs -> reverse proxy
```

Use the reverse proxy for host routing and certificates:

```text
plex.mgmt.nilsen-tech.com    -> reverse proxy :443 -> plex backend
grafana.mgmt.nilsen-tech.com -> reverse proxy :443 -> grafana backend
ombi.mgmt.nilsen-tech.com    -> reverse proxy :443 -> ombi backend
```

Fortigate VIPs are still useful for simple L4 translations, but they become awkward for many HTTPS apps sharing port `443` unless every app gets its own VIP address. For HTTP/S services, use Traefik or Nginx Proxy Manager with Cloudflare DNS-01 automation.

## Optional VIP Example

```hcl
enable_internal_tcp_vips = true

internal_tcp_vips = {
  "mgmt1-webtop-vip" = {
    comment     = "Internal webtop shortcut"
    extintf     = "bastion"
    extip       = "10.0.0.110"
    extport     = 443
    mapped_ip   = "10.0.0.100"
    mapped_port = 3000
  }
}
```

Prefer this only for simple TCP use cases. It does not give proper multi-host HTTPS routing by itself.
