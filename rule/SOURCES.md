# Rule sources

## Organized rules

- `Special.yaml`: locally maintained direct-first domains, including system
  and application-store update services.
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
- `Technology.yaml`: merged technology rules retained as a fallback for
  Microsoft, OneDrive, PayPal, and dependencies not caught earlier.
- `Domestic.yaml`: unified local direct exceptions, domestic AI and banks,
  the complete dler Domestic rules, and the former DomesticExtra remainder.
  Exact duplicate rules are removed. Updated against dler Domestic,
  MetaCubeX category-bank-cn/category-ai-cn and v2fly category-bank-cn on
  2026-11-19. The mixed collection uses classical YAML.
- `DomesticIP.yaml`: independent mainland China IP ranges, available as MRS.
- `ai.yaml`: merged locally maintained AI rules and MetaCubeX
  `category-ai-!cn`; `apple.yaml` and `tiktok.yaml` retain
  independent routing policies.
- `adblock.yaml`: snapshot of 217heidai Lite advertising-domain list.
  Active configurations fetch `adblockmihomolite.yaml` or
  `adblockmihomolite.mrs` directly from the upstream repository every 28800
  seconds. The committed snapshot supports local verification and manual use.

Compatible binary versions are stored under `mrs/`.
See `mrs/README.md` for the complete YAML/MRS mapping and conversion command.
Mixed domain/IP/keyword collections remain YAML.

## Loon and Quantumult X

- `hello_Loon.conf` uses Loon's native `Remote Proxy`, `Remote Filter`,
  `Proxy Group`, and `Remote Rule` sections. Use Loon 3.5.3 build 1008+.
- `hello_QuantumultX.conf` uses native `server_remote`, `server_local`,
  `policy`, and `filter_remote` sections. Reality/Vision syntax follows the
  current official sample (1.5.5+); verify support in the installed build.
- `*.loon.list` and `*.qx.list` are generated from the YAML sources. Finite
  domain regexes expand into explicit suffixes. The YouTube country pattern
  uses native domain wildcards. Process-name rules are omitted from these
  mobile exports. QX uses its native IP-filter semantics rather than
  copying Mihomo's no-resolve option.
- Node resources must use the selected client's native node-list format.
  Replace the example URLs and enable the resources before connecting.
  For an existing Airport/edgetunnel resource, retain its tag to preserve
  group references. With a third Loon resource, also add its alias to the
  Remote Filter definitions. QX regional groups filter all node tags.
- Region names must contain recognizable HK/TW/JP/SG/US or country names.
  Regional checks use 600 seconds and an 80 ms latency tolerance.
- Loon ForeignFly-AUTO uses a flattened SG, JP, US node/filter list. It
  chooses the first available node within each priority region. Selecting
  Auto_SG/Auto_JP/Auto_US manually uses latency selection inside that region.
- QX ForeignFly defaults to Auto_SG with Auto_JP/Auto_US available manually.
  Cross-region priority automation is not implemented by this native
  template. This avoids assuming nested automatic-policy behavior.
- QX server_check_url uses HTTP, matching the official sample and avoiding
  the malformed-server-check-URL import error seen with HTTPS probes.
  This probe setting does not change HTTPS DNS or application traffic.
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
  Domestic list, while local application/update exceptions remain first.
