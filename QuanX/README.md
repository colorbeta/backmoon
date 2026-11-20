# Quantumult X Configuration

The native profile is [hello_QuantumultX.conf](../hello_QuantumultX.conf).

See [cross-client recommended settings](../RECOMMENDED_SETTINGS.md) for default differences, profile-managed values and manual checks.

## Current Design

- Business destinations are REJECT, DIRECT, LocalFly, and ForeignFly. Five Auto groups expose regional status.
- Regional latency checks run every 600 seconds. ForeignFly defaults to Auto_SG; Auto_JP and Auto_US are manual alternatives, not an automatic cross-region priority chain.
- LAN and Special direct exceptions precede advertising. Dedicated services precede Domestic, Technology, and the final fallback.
- GitHub, including Copilot, uses LocalFly. Google and overseas AI use ForeignFly; mainland AI uses DIRECT.
- Special routes selected Apple/Microsoft downloads and updates directly without bypassing all shared CDNs.
- Encrypted DNS, no-system, and no-ipv6 are enabled. Device-level DNS verification is still required.
- Device reflection requires Quantumult X 1.9.0 build 952+ or a compatible later release.
- Rewrite, task, and HTTP backend sections are empty. Third-party tasks and MITM are not enabled by default.

## References And Attribution

References distinguish design reviews from resources actually used. Listing a project is not a complete fork, compatibility guarantee, or security endorsement.

| Project | Reference Scope | Treatment Here |
| --- | --- | --- |
| [crossutility/Quantumult-X](https://github.com/crossutility/Quantumult-X) | Official sections, policies, resource syntax | Basis for native syntax; complete section headers retained |
| [Quantumult X News](https://t.me/QuanXNews/434) | Build 952 reflected routes | Native reflection enabled with an explicit minimum version |
| [KOP-XIAO/QuantumultX](https://github.com/KOP-XIAO/QuantumultX) | Subscription conversion | Reviewed local snapshot, original attribution retained, dynamic filter/rename execution disabled, certificate verification enabled |
| [ddgksf2013/Profile](https://github.com/ddgksf2013/Profile) / [profile](https://ddgksf2013.top/Profile/QuantumultX.conf) | Resource layout, icons, domestic login Fake-IP exceptions | Selected ideas referenced; public nodes, unlock scripts, and ad rewrites not imported |
| [enriquephl/QuantumultX_config](https://github.com/enriquephl/QuantumultX_config) | Exact exceptions and separate download routing | Special refined; wholesale allowlists, system-DNS exceptions, and region-unlock policies not imported |
| [curtinp118/QuantumultX](https://github.com/curtinp118/QuantumultX) / [profile](https://github.com/curtinp118/QuantumultX/blob/main/profile/QX_Config.conf) | Region filters, destination hashing, manual diagnostics | Reviewed only; no new policies or scripts adopted |
| [217heidai/adblockfilters](https://github.com/217heidai/adblockfilters) | Lite advertising rules | Native QuanX Lite list referenced directly |
| [ClashConnectRules/Self-Configuration](https://github.com/ClashConnectRules/Self-Configuration), [Loyalsoldier/clash-rules](https://github.com/Loyalsoldier/clash-rules), [MetaCubeX/meta-rules-dat](https://github.com/MetaCubeX/meta-rules-dat) | Shared rule sources and classification | See [rule provenance](../Clash/rule/SOURCES.md) |
| [aaANDkk/Qure_Style_SVG](https://github.com/aaANDkk/Qure_Style_SVG) | Icon references | See [shared icons](../icon/README.md) |

## Review Of curtinp118

Useful ideas include excluding ambiguous region labels, optional manual diagnostics, and separating downloads from region-sensitive APIs. Destination hashing stabilizes selection for a target but is not SG-to-JP-to-US failover and does not guarantee one exit for every domain of an AI service.

The project's additional service groups, public subscription, global STUN/QUIC restrictions, and rewrites were not imported. Some leak-test keywords are explicitly proxied in its profile; a test page's visible exit cannot establish the DNS behavior of every app. This comparison is not a security audit of that project's complete rules or scripts.

## Resources And Maintenance

- [rule](rule/): native lists exported from [Clash sources](../Clash/rule/).
- [script](script/): fixed parser snapshot; see its [review notes](script/README.md). Updates require another review.
- No standalone QuanX modules are currently published, so there is no empty module directory.
- Private profiles remain outside Git in mylocal. Never publish subscription credentials, cookies, packet captures, CA private keys, or persistent account data.
- Each upstream keeps its own license. A design reference does not relicense scripts or imply a complete repository fork.

Reviewed on 2026-11-20. Native import, handshakes, DNS paths, and device reflection still require device testing.
