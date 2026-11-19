# Rule sources

## Organized rules

- `CNDirect.yaml`: MetaCubeX `category-ai-cn` plus local exceptions for
  Gamersky, Maycur, and MiniMax. These domains use `DIRECT`.

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
  rules. One classical YAML provider and the `GOOGLE` policy handle them all.
- `github.yaml`, `steam.yaml`, and `steam_cn.yaml`: MetaCubeX service rules.
- `telegram.yaml`: merged Telegram domains and IP ranges, using one YAML
  provider and the `TELEGRAM` policy.
- `cnbank.yaml`: MetaCubeX `category-bank-cn` domains routed directly.
- Repeated country suffixes in the Google, GitHub, Telegram, bank, domestic
  media, and technology lists use anchored regexes with explicit suffixes.
- `Technology.yaml`: merged technology rules retained as a fallback for
  Microsoft, OneDrive, PayPal, and dependencies not caught earlier.
- `Domestic.yaml` and `DomesticIP.yaml`: mainland China domain and IP rules.
- `ai.yaml`: merged locally maintained AI rules and MetaCubeX
  `category-ai-!cn`; `apple.yaml` and `tiktok.yaml` retain
  independent routing policies.
- `adblock.yaml`: snapshot of 217heidai Lite advertising-domain list.
  Active configurations fetch `adblockmihomolite.yaml` or
  `adblockmihomolite.mrs` directly from the upstream repository every 28800
  seconds. The committed snapshot supports local verification and manual use.

Compatible binary versions are stored under `mrs/`.
See `mrs/README.md` for the complete YAML/MRS mapping and conversion command.
`DomesticExtra.yaml` preserves the keyword and IP entries omitted from the
domain-only `Domestic.mrs`. Mixed process/keyword rule sets remain YAML.

## Upstream repositories

- https://github.com/ClashConnectRules/Self-Configuration
- https://github.com/Loyalsoldier/clash-rules
- https://github.com/dler-io/Rules
- https://github.com/blackmatrix7/ios_rule_script
- https://github.com/217heidai/adblockfilters
- https://github.com/MetaCubeX/meta-rules-dat
