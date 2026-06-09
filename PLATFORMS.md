# Platform notes

## OpenClash

- Use `hello_openclash.yaml`.
- Uses binary MRS versions of compatible domain rules for faster loading.
- Enable OpenClash local DNS hijack.
- Ensure Dnsmasq uses OpenClash as its only upstream DNS service.
- Disable conflicting DNS hijack features in other OpenWrt plugins.
- Keep IPv6 DHCP disabled unless IPv6 traffic is also routed through OpenClash.

## FlClash

- Use `hello_FlClash.yaml` on Windows and Android.
- Uses binary MRS versions of compatible domain rules for faster loading.
- Grant VPN/TUN permission.
- Disable browser Secure DNS and Android Private DNS when checking for leaks.
- The template hijacks TCP and UDP port 53 through Mihomo TUN.

## Stash

- Use `hello_Stash.yaml`.
- Uses YAML rule providers because MRS is a Mihomo-specific format.
- The template enables `follow-rule` so DNS queries follow routing rules.
- Stash manages the iOS VPN interface itself, so Mihomo TUN fields are omitted.
- Very large rule sets consume iOS Network Extension memory.

## Ubuntu Mihomo

- Use `hello_mihomo.yaml`.
- Uses binary MRS versions of compatible domain rules for faster loading.
- Run Mihomo with permission to create TUN routes.
- Ensure no other local service is already listening on DNS port 53.
- The template hijacks TCP and UDP port 53 and sends foreign DoH through `PROXY`.

## Private nodes

Public templates contain only placeholder subscription URLs. Generate or edit
private variants under `local/`; that directory is ignored by Git.

## Direct applications

The `Applications` provider comes from Loyalsoldier and sends common download
clients, proxy clients, and network tools through `SPECIAL`, which defaults to
`DIRECT`. This reduces proxy traffic but exposes the direct public IP for those
applications.
