# Platform notes

All templates use encrypted bootstrap DNS. Mihomo TUN templates keep
`strict-route` enabled and do not bypass mainland IP ranges outside the rule
engine, so DNS and routing decisions remain enforceable.

## Rule order

LAN rules run first, followed by explicit direct exceptions and advertising
rules. Domestic media and Steam CN precede overseas service rules. AI keeps
priority over shared dependencies, and dedicated overseas media, GitHub,
Telegram, Steam, Apple, and TikTok precede broad Google and technology rules.
Mainland domain/IP rules and the LocalFly catch-all run last.

Mihomo DNS rule-set policies follow the same service precedence. Broad
mainland DNS matching runs last so it cannot capture Google Play's
`googleapis.cn`. Stash uses explicit foreign DNS policies for the Google Play
China-domain exceptions.

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
