# Rule sources

## Organized rules

- `Special.yaml`: locally maintained direct-first domains, including system
  and application-store update services.
- `Applications.yaml`: Loyalsoldier `applications.txt`; common download
  clients, proxy clients, and network tools that should connect directly.
- `Private.yaml` and `LanCIDR.yaml`: Loyalsoldier private-network rules.
- `ForeignMedia.yaml`: merged YouTube, Netflix, and Spotify rules.
- `DomesticMedia.yaml`: merged Bilibili, iQIYI, NetEase Music, Tencent Video,
  and Youku rules.
- `Technology.yaml`: merged Google, GitHub, Microsoft, OneDrive, Telegram,
  and PayPal rules.
- `Domestic.yaml` and `DomesticIP.yaml`: mainland China domain and IP rules.
- `ai.yaml`, `google_fcm.yaml`, `apple.yaml`, and `tiktok.yaml`: services that
  retain independent routing policies.
- `adblock.yaml`: 217heidai full advertising-domain list.

Compatible binary versions are stored under `mrs/`.

## Upstream repositories

- https://github.com/ClashConnectRules/Self-Configuration
- https://github.com/Loyalsoldier/clash-rules
- https://github.com/dler-io/Rules
- https://github.com/blackmatrix7/ios_rule_script
- https://github.com/217heidai/adblockfilters
