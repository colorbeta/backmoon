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

## Upstream repositories

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
