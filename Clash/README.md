# Clash-Compatible Profiles

Shared rules for [OpenClash](../hello_openclash.yaml), [FlClash](../hello_FlClash.yaml), [Ubuntu Mihomo](../hello_mihomo.yaml), and [Stash](../hello_Stash.yaml). Complete profiles remain at the repository root.

## Resources And Behavior

- [rule](rule/): canonical YAML providers and [source records](rule/SOURCES.md).
- [mrs](mrs/): supported binary exports and [format mapping](mrs/README.md).
- Native exports: [Loon](../Loon/README.md), [QuanX](../QuanX/README.md).
- Optional overrides: [Stash](../Stash/README.md). Shared images: [icon](../icon/README.md).

Business destinations are REJECT, DIRECT, LocalFly and ForeignFly. LocalFly allows TW/HK/JP/SG; ForeignFly allows SG/JP/US. Regions test every 600 seconds. Mihomo ForeignFly-AUTO uses ordered SG-to-JP-to-US fallback.

LAN and Special exceptions precede ads. Dedicated services precede Domestic and Technology. GitHub including Copilot uses LocalFly; Google and overseas AI use ForeignFly; mainland AI uses DIRECT. Selected Apple/Microsoft downloads use Special/DIRECT. Unmatched traffic uses LocalFly.

OpenClash requires router-side DNS interception. FlClash and Ubuntu use TUN interception; FlClash intentionally has no standalone DNS listener. Stash manages its own VPN interface. Do not copy platform-specific TUN fields blindly. Configuration checks do not prove leak-free device behavior.

## References

- [ClashConnectRules/Self-Configuration](https://github.com/ClashConnectRules/Self-Configuration): classification and provider-based routing reference.
- [Loyalsoldier/clash-rules](https://github.com/Loyalsoldier/clash-rules): private-network and application sources.
- [MetaCubeX/meta-rules-dat](https://github.com/MetaCubeX/meta-rules-dat): service, AI, bank and IP sources.
- [dler-io/Rules](https://github.com/dler-io/Rules), [blackmatrix7/ios_rule_script](https://github.com/blackmatrix7/ios_rule_script): domestic and service sources.
- [217heidai/adblockfilters](https://github.com/217heidai/adblockfilters): active Lite adblocking.
- [Mihomo documentation](https://wiki.metacubex.one/), [Stash documentation](https://stash.wiki/): platform behavior.
- [Additional reference reviews](../QuanX/README.md): selected design comparisons, not wholesale imports.

Upstreams retain their licenses and attribution. Private profiles, credentials and tests remain outside Git. Offline Mihomo checks do not replace native iOS testing.
