# Rule sources

## Organized rules

- `Special.yaml`: locally maintained direct-first domains, including system
  and application-store update services.
- `Applications.yaml`: Loyalsoldier `applications.txt`; common download
  clients, proxy clients, and network tools that should connect directly.
- `Private.yaml` and `LanCIDR.yaml`: Loyalsoldier private-network rules.
- `ForeignMedia.yaml`: merged YouTube, Netflix, and Spotify rules.
- `DomesticMedia.yaml`: merged Bilibili, iQIYI, NetEase Music, Tencent Video,
  Youku, Quark, and AliPan rules.
- `google.yaml`, `google_ip.yaml`, `github.yaml`, `telegram.yaml`,
  `telegram_ip.yaml`, `steam.yaml`, and `steam_cn.yaml`: MetaCubeX service
  rules used by dedicated policy groups.
- `Technology.yaml`: merged technology rules retained as a fallback for
  Microsoft, OneDrive, PayPal, and dependencies not caught earlier.
- `Domestic.yaml` and `DomesticIP.yaml`: mainland China domain and IP rules.
- `ai.yaml`: merged locally maintained AI rules and MetaCubeX
  `category-ai-!cn`; `google_fcm.yaml`, `apple.yaml`, and `tiktok.yaml` retain
  independent routing policies.
- `adblock.yaml`: 217heidai full advertising-domain list.

Compatible binary versions are stored under `mrs/`.

## Upstream repositories

- https://github.com/ClashConnectRules/Self-Configuration
- https://github.com/Loyalsoldier/clash-rules
- https://github.com/dler-io/Rules
- https://github.com/blackmatrix7/ios_rule_script
- https://github.com/217heidai/adblockfilters
- https://github.com/MetaCubeX/meta-rules-dat
