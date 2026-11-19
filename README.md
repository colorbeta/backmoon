# backmoon

Platform-specific Mihomo/Clash configuration templates:

- `hello_openclash.yaml`: OpenWrt OpenClash. Enable DNS hijack in OpenClash.
- `hello_FlClash.yaml`: FlClash on Windows and Android, with TUN DNS hijack.
- `hello_Stash.yaml`: Stash on iOS, using Stash-compatible encrypted DNS.
- `hello_mihomo.yaml`: Mihomo on Ubuntu, with TUN DNS hijack.

Public templates contain subscription placeholders. Private nodes and tokens
belong in the ignored `mylocal/` directory.

All routing uses four destinations:

| Destination | Traffic |
| --- | --- |
| `REJECT` | Lite advertising rules |
| `DIRECT` | Mainland services, banks, domestic AI/media, LAN, updates, download apps, Steam CN |
| `LocalFly` | Overseas media, technology, GitHub, Telegram, Steam, TikTok, Apple, unmatched traffic |
| `ForeignFly` | Overseas AI and Google, including FCM |

`LocalFly` selects among Taiwan, Hong Kong, Japan, and Singapore nodes.
`ForeignFly` selects among Singapore, Japan, and US nodes.
Both groups use latency-based automatic selection every 600 seconds with an
80 ms switching tolerance. Subscription nodes are filtered by their names;
private Oracle Japan and Singapore nodes are included explicitly.

See `PLATFORMS.md` for client setup and `mrs/README.md` for the rule mapping.
Supported binary domain/IP rule sets are stored under `mrs/`.
