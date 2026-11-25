# Clash-Compatible Profiles

Shared rules for [OpenClash](../hello_openclash.yaml), [FlClash](../hello_FlClash.yaml), [Ubuntu Mihomo](../hello_mihomo.yaml), and [Stash](../hello_Stash.yaml). Complete profiles remain at the repository root.

See [cross-client recommended settings](../RECOMMENDED_SETTINGS.md) for engine-default differences, app overrides and manual settings.

## Resources And Behavior

- [rule](rule/): canonical YAML providers and [source records](rule/SOURCES.md).
- [mrs](mrs/): supported binary exports and [format mapping](mrs/README.md).
- Native exports: [Loon](../Loon/README.md), [QuanX](../QuanX/README.md).
- Optional overrides: [Stash](../Stash/README.md). Shared images: [icon](../icon/README.md).

Business destinations are REJECT, DIRECT, LocalFly, ForeignFly and MicroSoft. MicroSoft is a manual selector defaulting to DIRECT, with LocalFly, ForeignFly and individual regions as alternatives. LocalFly allows TW/HK/JP/SG; ForeignFly allows SG/JP/US. Regions test every 600 seconds. Mihomo ForeignFly-AUTO uses ordered SG-to-JP-to-US fallback.

Priority is Forbid, LAN, adblock, Special, Applications, dedicated services, Domestic and Technology, then final fallback. Advertising rejection wins over overlapping Special or application-direct entries. GitHub including GitHub Copilot uses LocalFly; Google and overseas AI use ForeignFly; mainland AI uses DIRECT. Selected Apple downloads use Special/DIRECT. Microsoft, Live, Windows, Outlook, Office, Bing, OneDrive and Microsoft Copilot use MicroSoft, including Microsoft updates and Phone Link endpoints. Precise GitHub/OpenAI cloud-tenant rules precede MicroSoft; unrelated shared hosting/CDN roots are not added to that set. Unmatched traffic uses LocalFly.

MicroSoft DNS in Mihomo profiles uses encrypted resolvers routed through the selected MicroSoft policy. Stash, Loon and QuanX retain their existing native encrypted DNS behavior. Switching the group can affect Microsoft downloads, authentication, Copilot availability and region detection. This routing change alone does not prove that Phone Link's roaming restriction is resolved; phone-side VPN, location permissions and corporate network restrictions still matter.

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
