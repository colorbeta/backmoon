# Rule sources

## Organized rules

- `Special.yaml`: locally maintained direct-first exceptions and Apple
  system/application-store update services. Microsoft updates are in MicroSoft.
- `MicroSoft.yaml`: Microsoft/OneDrive domain rules extracted from Technology,
  Microsoft update/connectivity domains moved from Special, and Microsoft login
  and Copilot domains moved from AI. The MicroSoft selector defaults to DIRECT
  and permits LocalFly, ForeignFly or an individual regional group. It includes
  Live, Windows, Outlook, Office, Bing and Phone Link's dcg.microsoft.com.
  Shared CDN/hosting roots and separately owned services are not reclassified
  as Microsoft merely because they occurred in the legacy Microsoft block.
  GitHub Copilot and precise OpenAI/GitHub cloud-tenant rules retain priority.
  Finite domain regexes expand in native lists and the domain-only MRS export.
- T3 Connect tunnel compatibility: argotunnel.com, cfargotunnel.com and
  t3coderelay.com use Special/DIRECT. The profiles also exclude their root
  names and/or subdomains from Fake IP using each client's supported form:
  YAML fake-ip-filter, Loon real-ip, QuanX dns_exclusion_list. No global
  Fake-IP disable, process-wide bypass or broad Cloudflare DIRECT rule was added.
  Reference: https://linux.do/t/topic/3206018 (community troubleshooting report,
  not a guarantee that Fake IP is always incompatible with cloudflared).
  Cloudflare documents outgoing TCP/UDP 7844 for tunnel transport:
  https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/configure-tunnels/tunnel-with-firewall/
  Direct reachability and native DNS behavior still require device testing.
  Forbid and advertising keep their earlier positions. T3 Code's t3.codes
  domain remains in AI/ForeignFly; it is distinct from the relay domain.
- `Applications.yaml`: Loyalsoldier `applications.txt` plus locally maintained
  GameViewer process names; these applications use direct connections.
- `Private.yaml` and `LanCIDR.yaml`: Loyalsoldier private-network rules.
- `ForeignMedia.yaml`: merged YouTube, Netflix, and Spotify rules. An anchored
  domain regex groups YouTube country suffixes while preserving CDN rules.
- `DomesticMedia.yaml`: merged Bilibili, iQIYI, NetEase Music, Tencent Video,
  Youku, Quark, and AliPan rules.
- `google.yaml`: merged MetaCubeX Google domains/IPs and blackmatrix7 FCM
  rules. One classical YAML provider sends them through `ForeignFly`.
- `github.yaml`, `steam.yaml`, and `steam_cn.yaml`: MetaCubeX service rules.
- `telegram.yaml`: merged Telegram domains and IP ranges, using one YAML
  provider and the `LocalFly` policy.
- Repeated country suffixes in the Google, GitHub, Telegram, bank, domestic
  media, and technology lists use anchored regexes with explicit suffixes.
- `Technology.yaml`: remaining technology rules retained as a fallback for
  PayPal, shared cloud/CDN infrastructure and dependencies not caught earlier.
- `Domestic.yaml`: unified local direct exceptions, domestic AI and banks,
  the complete dler Domestic rules, and the former DomesticExtra remainder.
  Exact duplicate rules are removed. Updated against dler Domestic,
  MetaCubeX category-bank-cn/category-ai-cn and v2fly category-bank-cn on
  2026-11-19. The mixed collection uses classical YAML.
- `DomesticIP.yaml`: independent mainland China IP ranges, available as MRS.
- `ai.yaml`: merged locally maintained AI rules and MetaCubeX
  `category-ai-!cn`; `apple.yaml` and `tiktok.yaml` retain
  independent routing policies.
- T3 Code: t3.codes and its subdomains use the AI policy (ForeignFly).
  This covers the official website and app.t3.codes web surface, not an
  exhaustive runtime allowlist. The coding agents use their own provider
  endpoints; GitHub downloads retain the GitHub policy. Local/private
  environment connections remain local. Custom API bases and remote
  environments may need separate classification based on their actual hosts.
  References: https://github.com/pingdotgg/t3code and
  https://github.com/pingdotgg/t3code/blob/main/docs/user/remote-access.md
- `adblock.yaml`: snapshot of 217heidai Lite advertising-domain list.
  Active configurations fetch `adblockmihomolite.yaml` or
  `adblockmihomolite.mrs` directly from the upstream repository every 28800
  seconds. The committed snapshot supports local verification and manual use.

Compatible binary versions are stored under `mrs/`.
See `Clash/mrs/README.md` for the complete YAML/MRS mapping and conversion command.
Mixed domain/IP/keyword collections remain YAML.

## Platform Layout And Priority

Forbid.yaml is a user-maintained classical deny ruleset before advertising.
YAML profiles use RULE-SET,Forbid,REJECT; native Loon/QuanX lists are exported
with the same REJECT policy. No forbid proxy group or hard-coded inline deny
is needed. Its first entry exactly matches play.googleapis.com, not other
Google domains or subdomains. Add future entries to Clash/rule/Forbid.yaml
and regenerate native exports. Refresh the Forbid resource in each client;
profile imports are needed only when adding the provider for the first time.
Keep this set as classical YAML rather than domain-only MRS to allow future
supported keyword/IP rules. Existing local/plugin precedence still
applies; placing it before advertising is not a promise to override every
local exception or plugin rule on every platform.
The requested X post could not be retrieved, so its claims were not verified.
Google documents this host for Chrome logs and a connectivity-test alternative:
https://support.google.com/chrome/a/answer/6350036?hl=en
https://support.google.com/chrome/a/answer/6334001?hl=en
Blocking the entire hostname also affects those uses; this is not a claim
that the hostname is exclusively a tracker or that all DNS leakage is solved.

Special remains the shared DIRECT service set after adblocking. It is
grouped into exact compatibility allowlist, Apple update/content download,
and user exceptions. Microsoft update/download and Windows connectivity
domains now use the separate MicroSoft policy, defaulting to DIRECT.
Apple connectivity and certificate checks use exact hosts. No blanket akamaized.net/edgesuite.net
exception, analytics allowlist, public CA private key, or TLS interception
was added. Direct reachability still depends on the user's network.
Endpoint references:
- https://support.apple.com/en-us/101555
- https://learn.microsoft.com/en-us/windows/privacy/manage-windows-11-endpoints
- https://learn.microsoft.com/en-us/troubleshoot/windows-client/networking/internet-explorer-edge-open-connect-corporate-public-network

FlClash keeps its internal DNS resolver and TUN DNS hijacking enabled but
does not bind a standalone dns.listen port. This avoids Windows refusing
TCP/UDP 1053 while preserving encrypted DNS policies. Keep TUN enabled
for system DNS capture; programs explicitly querying 127.0.0.1:1053 must
not rely on that removed listener. OpenClash/server listeners are unchanged.

Root hello_* profiles reference Clash/rule (canonical YAML, also for Stash),
Clash/mrs (binary exports), Loon/rule and QuanX/rule (native lists).
Loon/module contains the loopback plugin, QuanX/script the fixed parser;
icon remains shared. Private profiles and experimental modules stay outside
the Git repository in mylocal and are never published.

Forbid precedes LAN, then ads, Special and application-direct rules, followed
by dedicated services and finally
Domestic, Technology, domestic IPs and Final. GitHub including Copilot now
uses LocalFly before AI. Overseas media precedes Google to preserve YouTube
on LocalFly. snssdk.com was removed from TikTok; pstatp.com, snssdk.com and
maintained mainland ByteDance domains use Domestic/DIRECT. Ads still block
before generic domestic domains. Global TikTok/CDNs such as byteoversea.com,
ipstatp.com and sgpstatp.com remain separate overseas rules.

## Loon and Quantumult X

- `hello_Loon.conf` uses Loon's native `Remote Proxy`, `Remote Filter`,
  `Proxy Group`, and `Remote Rule` sections. Use Loon 3.5.3 build 1008+.
- `hello_QuantumultX.conf` uses native `server_remote`, `server_local`,
  `policy`, and `filter_remote` sections. Enabled device reflection requires
  QX 1.9.0 build 952+ or a compatible later release.
- `Loon/rule/*.list` and `QuanX/rule/*.list` are generated from the YAML sources. Finite
  domain regexes expand into explicit suffixes. The YouTube country pattern
  uses native domain wildcards. Process-name rules are omitted from these
  mobile exports. QX uses its native IP-filter semantics rather than
  copying Mihomo's no-resolve option.
- Loon node resources must use its native node-list format. QX enables
  KOP-XIAO's resource parser for node subscriptions. Its #cert=1 resource
  fragment forces TLS certificate verification during node conversion;
  do not use cert=-1 to work around certificate errors. The parser is
  third-party code that can access subscription contents. Profiles now use
  the manually maintained, hardened snapshot in script/resource-parser.js;
  dynamic sfilter/srename execution is disabled. See script/README.md.
  This is separate from the empty rewrite/task sections.
  The private Edge QX resource follows the working attachment's base URL,
  without target=quanx; conversion occurs in the client.
  Replace the example URLs and enable the resources before connecting.
  For an existing Airport/edgetunnel resource, retain its tag to preserve
  group references. With a third Loon resource, also add its alias to the
  Remote Filter definitions. QX regional groups filter all node tags.
- Region names must contain recognizable HK/TW/JP/SG/US or country names.
  Regional checks use 600 seconds and an 80 ms latency tolerance.
- Loon ForeignFly-AUTO uses Auto_SG, Auto_JP, Auto_US in fallback order.
  Regions use latency selection with switching tolerance; the outer group
  controls country priority. Native behavior still requires device testing.
- QX ForeignFly defaults to Auto_SG with Auto_JP/Auto_US available manually.
  Cross-region priority automation is not implemented by this native
  template. This avoids assuming nested automatic-policy behavior.
- QX server_check_url uses HTTP, matching the official sample and avoiding
  the malformed-server-check-URL import error seen with HTTPS probes.
  This probe setting does not change HTTPS DNS or application traffic.
- QX retains all 12 section headers from the official sample, including
  rewrite_remote, rewrite_local, task_local, http_backend, and mitm even
  when unused. The local validator compares the complete section schema
  with a downloaded official sample and checks each missing-header case.
- Reviewed https://ddgksf2013.top/Profile/QuantumultX.conf for native
  resource layout, the profile icon, and domestic login DNS exclusions.
  Existing LocalFly/ForeignFly routing, 600-second checks, 217heidai Lite,
  and encrypted DNS remain in place. No reference nodes, paid-feature
  rewrites, TLS interception, blanket UDP 443 blocking, CDN DNS aliases,
  or plaintext DNS servers were imported. Certificate validation is not
  skipped; rewrite/task/backend sections are intentionally empty.
- Both clients configure native encrypted DNS and their VPN interfaces.
  Loon uses IPv4-only mode; QX disables AAAA answers with no-ipv6 and uses
  no-system and remote resolution for proxy traffic.
  Loon can fall back to ordinary DNS by default: disable that fallback in
  the app's DNS server settings (https://nsloon.app/docs/DNS/).
  Neither profile claims Mihomo's DNS proxy-fragment behavior. Validate DNS
  on the device. Optional STUN blocking is disabled for voice/video use.
- Lite adblocking references 217heidai's native Loon/QX rules directly.
- Private copies in mylocal contain the existing Oracle nodes and private
  URLs. Native Reality syntax has no copied Mihomo-specific
  support-x25519mlkem768 setting; key-exchange behavior requires client and
  server verification. Never publish these private copies.
- Only structural, conversion, and rule-coverage tests are available here.
  iOS import, DNS packet paths, and node handshakes require device testing.

### Native documentation

- https://github.com/Loon0x00/LoonExampleConfig/blob/master/example2.lcf
- https://github.com/Loon0x00/LoonExampleConfig/blob/master/Nodes/ExampleNodes.list
- https://github.com/crossutility/Quantumult-X/blob/master/sample.conf

### Upstream repositories

- https://github.com/ClashConnectRules/Self-Configuration
- https://github.com/Loyalsoldier/clash-rules
- https://github.com/dler-io/Rules
- https://github.com/blackmatrix7/ios_rule_script
- https://github.com/217heidai/adblockfilters
- https://github.com/MetaCubeX/meta-rules-dat

## Domestic merge audit

- Self-Configuration currently references dler Domestic (340 rules).
- Loyalsoldier direct.txt was reviewed (110247 entries). This merge follows
  the existing dler source and the targeted bank/AI sources rather than
  importing the entire alternative list.
- The merged file has 553 exact-deduplicated rules, including 90 additions
  relative to the former four-file union. DomesticExtra is already a subset
  of Domestic, so its entries are not duplicated.
- Google and other explicit overseas services precede Domestic, preserving
  Google Play's googleapis.cn exception. Overseas AI only matches when its
  destination is absent from Domestic. Advertising rules precede the merged
  Domestic list. Current ordering places Special/application-direct rules
  after advertising; only explicit native local exceptions retain local priority.
