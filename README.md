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

`LocalFly` offers automatic selection or manual choice of Taiwan, Hong Kong,
Japan, and Singapore groups. `ForeignFly` offers automatic selection or
manual choice of Singapore, Japan, and US groups. Both default to automatic.

Five visible regional groups expose node status and latency. They test every
600 seconds with an 80 ms switching tolerance, including inactive regions.
Hidden `LocalFly-AUTO` and `ForeignFly-AUTO` groups select the best regional
group. Subscription nodes are filtered by name; Oracle Japan and Singapore
nodes are included explicitly in the private variants.

See `PLATFORMS.md` for client setup and `mrs/README.md` for the rule mapping.
Supported binary domain/IP rule sets are stored under `mrs/`.

Policy-group icons are mirrored under `icon/` with SVG sources, compatible
PNG copies, and upstream attribution. All platform and private templates
reference the PNG versions from this repository.
