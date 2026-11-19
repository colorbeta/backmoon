# Platform notes

All templates use encrypted bootstrap DNS. Mihomo TUN templates keep
`strict-route` enabled and do not bypass mainland IP ranges outside the rule
engine, so DNS and routing decisions remain enforceable.

## Rule order

LAN rules run first, followed by explicit local application/update exceptions
and advertising rules. Steam CN and domestic media use DIRECT. Overseas AI
matches only destinations outside Domestic. Specific overseas services
precede the unified Domestic list, and the broad Technology list follows it.
Mainland IP rules and the LocalFly catch-all run last.

Domestic includes banks, mainland AI, local direct domains, and the original
dler direct exceptions. Its mixed rule types use one classical YAML provider.
DNS preserves the domestic MiniMax exception before the AI policy, puts
specific overseas services before Domestic, and evaluates Technology last.
Stash uses explicit Google Play China-domain and domestic AI DNS policies.

## Regional groups

LocalFly and ForeignFly are manual selectors with an automatic option first.
Five visible groups (Hong Kong, Taiwan, Japan, Singapore, US) expose regional
node status. Regional url-test checks run every 600 seconds even when the
region is not currently selected. Hidden Fly-AUTO groups provide automatic
selection across the allowed regions. Users can pin a region in either Fly
selector; the chosen region then selects its lowest-latency node.

Mihomo templates use `empty-fallback: REJECT` only for empty groups, rather
than listing REJECT as a normal regional candidate. Subscription refreshes
explicitly use DIRECT so they do not depend on already-populated Fly groups.
Regional filters accept numbered names such as HK01, TW01, and HongKong01.
Provider health checks disable lazy mode so inactive regions are refreshed
on the same 600-second schedule.

## OpenClash

- Use `hello_openclash.yaml`.
- Uses binary MRS versions of compatible domain rules for faster loading.
- Enables concurrent TCP dialing, connection keepalive, regional auto-selection,
  and rule-set-based split DNS.
- Enable OpenClash local DNS hijack.
- Ensure Dnsmasq uses OpenClash as its only upstream DNS service.
- Disable conflicting DNS hijack features in other OpenWrt plugins.
- Keep IPv6 DHCP disabled unless IPv6 traffic is also routed through OpenClash.

## FlClash

- Use `hello_FlClash.yaml` on Windows and Android.
- Uses binary MRS versions of compatible domain rules for faster loading.
- Enables concurrent TCP dialing, connection keepalive, regional auto-selection,
  and rule-set-based split DNS.
- Grant VPN/TUN permission.
- Disable browser Secure DNS and Android Private DNS when checking for leaks.
- The template hijacks TCP and UDP port 53 through Mihomo TUN.

## Stash

- Use `hello_Stash.yaml`.
- Uses YAML rule providers for compatibility with older Stash releases;
  current Stash versions can also read domain/IP MRS providers.
- The template enables `follow-rule` so DNS queries follow routing rules.
- DNS policies use domestic resolvers for mainland/private domains and
  encrypted foreign resolvers for AI and overseas technology services.
- Enable **Concurrent Connections** in Stash Network Settings; Mihomo's
  `tcp-concurrent` and keepalive keys are intentionally omitted.
- Stash manages the iOS VPN interface itself, so Mihomo TUN fields are omitted.
- Very large rule sets consume iOS Network Extension memory.

## Ubuntu Mihomo

- Use `hello_mihomo.yaml`.
- Uses binary MRS versions of compatible domain rules for faster loading.
- Enables concurrent TCP dialing, connection keepalive, regional auto-selection,
  and rule-set-based split DNS.
- Run Mihomo with permission to create TUN routes.
- Ensure no other local service is already listening on DNS port 53.
- The template hijacks TCP and UDP port 53. AI/Google DoH uses `ForeignFly`;
  other overseas DoH uses `LocalFly`.

## Private nodes

Public templates contain only placeholder subscription URLs. Generate or edit
private variants under `mylocal/`; that directory is ignored by Git.

## Direct applications

The `Applications` provider comes from Loyalsoldier and sends common download
clients, proxy clients, and network tools through `DIRECT`. This reduces proxy
traffic but exposes the direct public IP for those
applications.
