# Recommended Client Settings

Reviewed: 2026-11-20. This guide matches the repository profiles, not an assertion that settings have been applied to a device. Menu labels, factory defaults and app overrides vary by version. Reconnect the VPN after changing tunnel/routing settings.

## Default Labels

- **DIFFERENT**: a recommendation differs from a verified upstream baseline. The row states whether that baseline is an engine default, documented behavior, or another source.
- **SAME**: a documented baseline is retained.
- **VERIFY VERSION**: the installed app's factory default is not established. Check it manually; do not interpret an upstream sample value as a factory default.
- **PROFILE**: a project-specific value, not a factory-default claim. The imported profile already contains it unless an app override takes precedence.

## Priority Checks: Differences From Defaults

| Client / Setting | Verified Baseline | Recommended / Current Value | Status And Action |
| --- | --- | --- | --- |
| Loon: fall back from encrypted DNS to ordinary DNS | Enabled by default according to Loon DNS documentation | Off for this encrypted-DNS setup | **DIFFERENT**; change manually in the app's DNS settings; failures can then become visible instead of silently using ordinary DNS |
| FlClash / Mihomo: TUN enable | Disabled in the upstream core default config | Enabled | **DIFFERENT (engine)**; profile sets true; grant the required VPN/elevation permission and inspect app overrides |
| FlClash / Mihomo: built-in DNS enable | Disabled in the upstream core default config | Enabled | **DIFFERENT (engine)**; supplied by the profile |
| FlClash / Mihomo: concurrent TCP dialing | Disabled in the upstream core default config | Enabled | **DIFFERENT (engine)**; supplied by the profile |
| QuanX: system DNS participation | Normally participates when no encrypted global resolver or no-system exception excludes it | Explicit no-system plus global DoH | **DIFFERENT (documented DNS baseline)**; supplied by the profile; global encrypted DNS already excludes ordinary global resolvers |
| QuanX: unsupported-UDP fallback | reject by documented default | reject | **SAME**; keep it rather than introducing direct fallback |

Engine defaults above are not claims about a fresh FlClash installation's UI. FlClash can write its own effective configuration. Compare the running configuration with the imported profile if behavior differs. Sources: [Mihomo defaults](https://github.com/MetaCubeX/mihomo/blob/Meta/config/config.go), [Loon DNS](https://nsloon.app/docs/DNS/), [QuanX sample and parameter notes](https://github.com/crossutility/Quantumult-X/blob/master/sample.conf).

## Cross-Client Checklist

The editable Forbid ruleset precedes adblocking and maps directly to REJECT;
there is no additional proxy group. Maintain Clash/rule/Forbid.yaml and its
native exports. The first rule blocks exactly play.googleapis.com, including
legitimate uses, not other googleapis.com hosts. See [rule notes](Clash/rule/SOURCES.md).

The configured order is Forbid, LAN, adblock, Special, application-direct,
dedicated services and broad fallback. Special does not bypass advertising.
Loon's former local Special copy was removed; native local/plugin priority
still needs to be considered when adding future exceptions.

| Item | Loon | Stash | QuanX | FlClash |
| --- | --- | --- | --- | --- |
| Normal routing | Rule mode | Rule mode | Rule/filter mode | Rule mode |
| VPN / interception | TUN Only for the diagram's DNS-blocking workflow | Native Stash VPN | Native QuanX VPN | TUN enabled for system-wide capture |
| ForeignFly | Auto_SG, then Auto_JP, then Auto_US | Same region priority | Manual region, defaults to Auto_SG | Same priority as Loon/Stash |
| Regional selection | Latency test, 600 s, 80 ms tolerance | Same | Same | Same |
| Device reflection | Enabled plugin for 10.7.0.1 | App loopback-route setting, only if needed | reflected_routes enabled; requires build 952+ | Not enabled by this profile |
| MITM | Only for enabled HTTPS-rewrite plugins and a personal trusted CA | Optional JD override only when explicitly enabled | Off unless deliberately adding a reviewed rewrite | Not configured by this project's profile |

These rows are **PROFILE** values or workflow recommendations. App factory defaults are **VERIFY VERSION** unless documented above. Latency preference is not maximum download bandwidth. The 80 ms tolerance can keep a nearly as fast node. A saved manual selection overrides the default automatic option; verify the selected child of LocalFly and ForeignFly.

## Loon

See the detailed [diagram-based checklist](Loon/README.md#recommended-app-settings-checklist) and [plugin review](Loon/module/README.md).

| Manual Setting | Recommendation | Default Status |
| --- | --- | --- |
| TUN Only / default-route handling | Use TUN Only; do not enable Do Not Use As Default Route for this workflow | **VERIFY VERSION** |
| SNI-assisted matching | On, already configured | **PROFILE**; UI factory value unverified |
| Hide automatic groups | Off to inspect the five regions | **VERIFY VERSION** |
| Simple mode | Off if icons should be visible; the reference diagram uses On | **VERIFY VERSION**; differs from the diagram, not a verified factory default |
| Error and memory notifications | On; routine subscription/change notifications optional | **VERIFY VERSION** |
| Scripts / Rewrite | On only when required by enabled plugins | **VERIFY VERSION** |
| MITM, HTTP/2 MITM, QUIC fallback protection | Enable compatible rewrite features only after configuring a personal CA and limited hosts | **VERIFY VERSION**; not a blanket decryption recommendation |
| Global STUN blocking | Keep current compatibility choice; direct-STUN blocking is an optional privacy tradeoff | **PROFILE** uses disable-stun=false; direct-only UI scope can differ |

The profile uses a 5-second test timeout, not the diagram's 2 seconds. Keep unreviewed plugins disabled. DNS rejection returning LoopbackIP is unrelated to sideloading IP reflection. Broad bypass routes and globally disabling QUIC/STUN are not mandatory recommendations.

## Stash

| Manual Setting | Recommendation | Default Status |
| --- | --- | --- |
| Concurrent Connections in Network Settings | Enable if available for CDN connection racing | **VERIFY VERSION**; the official guide identifies manually enabled performance features, not a universal factory state |
| Hybrid Wi-Fi/cellular use | Optional, not required; consider cellular traffic and battery costs | **VERIFY VERSION** |
| Tunnel loopback routing | Enable when using a compatible sideloaded tool; reconnect and test | **VERIFY VERSION**; app setting exists in the user's installation; no invented YAML key is added |
| External access / LAN sharing | Leave off unless explicitly needed | **VERIFY VERSION**; configure strong authentication before exposing a controller |
| Overrides | Enable only the reviewed override needed for the task | **PROFILE**; JD Price is published separately, not included automatically |
| MITM / CA trust | Only for a required HTTPS rewrite; generate and trust your own CA | **VERIFY VERSION**; no certificate is distributed |

The profile already contains encrypted DNS and follow-rule. Stash manages its tunnel: do not copy Mihomo TUN keys or the Loon STUN switches into it. Avoid stacking multiple huge adblock lists. See [Stash performance settings](https://stash.wiki/en/features/network-performance-enhance), [MITM guidance](https://stash.wiki/en/http-engine/mitm), and the [loopback announcement](https://t.me/StashFeed/222). The announcement alone does not establish compatibility with every sideloaded tool.

## Quantumult X

| Item | Recommendation / Current State | Default Status |
| --- | --- | --- |
| System DNS | Keep no-system and encrypted DNS | **DIFFERENT baseline**, as qualified above; profile-managed |
| AAAA responses | Keep no-ipv6 until IPv6 routing is deliberately tested | **PROFILE**; app factory default unverified |
| Edge/Airport resource parsing | Keep the repository parser and opt-parser=true, with the cert=1 resource fragment | **PROFILE**; no factory parser selection is assumed |
| Reflected route | Keep 10.7.0.1/32 only on version 1.9.0 build 952+ or a compatible later build | **PROFILE**; not safe to import into an older version |
| ForeignFly selection | Auto_SG normally; choose Auto_JP/Auto_US manually if required | **PROFILE**; this is not automatic cross-region fallback |
| Rewrite / MITM / tasks | Leave unused capabilities inactive; do not add public CA material | **VERIFY VERSION** for UI defaults; profile sections are empty |
| Global STUN/QUIC drops | Do not enable by default; assess calls, video and games first | **PROFILE** keeps the optional drop line commented |

Do not change the HTTP server_check_url to HTTPS merely to match DoH: these are separate features. Keep DNS exclusions narrow. See the [QuanX guide](QuanX/README.md), [official parameter notes](https://github.com/crossutility/Quantumult-X/blob/master/sample.conf), and [reflection update](https://t.me/QuanXNews/434).

## FlClash On Windows And Android

| Manual Setting | Recommendation | Default Status |
| --- | --- | --- |
| TUN / VPN permission | Enable for this profile; allow elevation/helper access when prompted | **DIFFERENT engine default**, UI factory default **VERIFY VERSION** |
| System proxy | Optional for apps using it; not a substitute for TUN interception | **VERIFY VERSION** |
| Per-field DNS/TUN overrides | Prefer profile values; inspect any selected override that replaces them | **VERIFY VERSION**; an import can retain app-level settings |
| Application access control | Include intended apps; deliberate exclusions bypass the shared policy | **VERIFY VERSION** |
| Android battery settings | If the VPN is killed in the background, allow necessary background operation and test | **VERIFY VERSION**; not a requirement to disable all OS power controls |
| LAN sharing | Off unless needed | **PROFILE** uses allow-lan=false and loopback bind |
| Controller access | Keep local-only; use a private strong secret if the API is used | **PROFILE** binds loopback but has an empty secret; this is not authenticated API protection |

The profile enables strict TUN routing, DNS interception, encrypted split DNS and concurrent TCP dialing. It intentionally has no standalone DNS listener: do not manually point the OS to 127.0.0.1:1053. In recent builds, inspect effective per-key overrides rather than assuming all imported values won. See [FlClash project](https://github.com/chen08209/FlClash), [release/override notes](https://chen08209.github.io/FlClash/), and [Mihomo DNS documentation](https://wiki.metacubex.one/config/dns/).

## OpenClash And Ubuntu

- OpenClash: enable the router's supported DNS interception workflow, make Dnsmasq forward only to the intended resolver, and avoid competing hijackers. Inspect whether OpenClash UI settings overwrite profile DNS/groups. Keep IPv6 disabled until end-to-end routing is verified. Router defaults are **VERIFY VERSION**.
- Ubuntu Mihomo: grant TUN/route permissions, inspect existing local DNS listeners before enabling any standalone DNS service, and verify routing after restart. The desktop FlClash port-binding workaround is not a reason to remove a server listener that another device intentionally uses.

## Verification After Applying Settings

For T3 Connect/cloudflared troubleshooting, Special directs argotunnel.com,
cfargotunnel.com and t3coderelay.com, with matching real-address/Fake-IP
exceptions in each profile. Import the updated profile as well as refreshing
Special: a ruleset refresh alone does not add DNS exceptions. Do not disable
Fake IP globally or proxy all traffic on a tunnel port. If the local network
blocks outgoing 7844, DIRECT rules alone cannot make that tunnel reachable.
This follows a [community report](https://linux.do/t/topic/3206018) with the
[Cloudflare port requirements](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/configure-tunnels/tunnel-with-firewall/)
checked separately; no live tunnel test was performed.

1. Confirm the active profile and rule mode. Avoid another VPN or DNS-interception tool competing for the same traffic.
2. Confirm private subscription resources load and each expected region has usable candidates. Do not enable public placeholders.
3. Check a mainland domain uses DIRECT, ChatGPT/Google use ForeignFly, GitHub uses LocalFly, and specified update hosts use Special/DIRECT.
4. Reconnect after tunnel changes. During DNS diagnostics, account for browser Secure DNS, Android Private DNS and app-owned DoH; disabling them temporarily for a controlled test is not a universal security recommendation.
5. Inspect actual DNS requests and connection exits on Wi-Fi and cellular. One leak-test webpage cannot establish all-app behavior.
6. Test any sideloaded tool independently. Reflection is not the same as DIRECT routing or DNS loopback rejection.
7. Enable HTTPS rewrites one at a time. Keep personal CA keys and captured account data out of Git and shared logs.

Only documentation is changed by this guide. The separate local Chinese guides are not published. Factory defaults marked VERIFY VERSION remain unconfirmed until checked against the installed build or a reset test device.
