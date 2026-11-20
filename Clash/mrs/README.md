# MRS Rule Mapping

Editable sources are in Clash/rule; supported binary exports are in Clash/mrs. MRS supports domain and ipcidr behavior, not arbitrary classical rules.

| YAML Source | Binary Export | Purpose | Policy |
| --- | --- | --- | --- |
| adblock.yaml | adblock.mrs | Lite snapshot; active clients fetch upstream every 8 hours | REJECT |
| ai.yaml | ai.mrs | Overseas AI domains | ForeignFly |
| Domestic.yaml | YAML only | Mainland AI, banks, domains, keywords, direct IP exceptions | DIRECT |
| DomesticIP.yaml | DomesticIP.mrs | Mainland IP prefixes | DIRECT |
| github.yaml | YAML only | GitHub, Copilot, related dependencies and anchored regex | LocalFly |
| google.yaml | YAML only | Google domains, IPs and FCM | ForeignFly |
| LanCIDR.yaml | LanCIDR.mrs | Private IP ranges | DIRECT |
| Private.yaml | Private.mrs | Private-network domains | DIRECT |
| Special.yaml | Special.mrs | Precise exceptions and update/download services | DIRECT |
| steam.yaml | steam.mrs | Steam services | LocalFly |
| steam_cn.yaml | steam_cn.mrs | Mainland Steam downloads | DIRECT |
| telegram.yaml | YAML only | Telegram domains, regex and IPs | LocalFly |
| tiktok.yaml | tiktok.mrs | Overseas TikTok domains | LocalFly |
| Applications.yaml | YAML only | Direct application process names | DIRECT |
| apple.yaml | YAML only | Apple services outside earlier exceptions | LocalFly |
| DomesticMedia.yaml | YAML only | Mainland media and application exceptions | DIRECT |
| ForeignMedia.yaml | YAML only | Overseas media | LocalFly |
| Technology.yaml | YAML only | Remaining technology services | LocalFly |

OpenClash, FlClash and Ubuntu Mihomo profiles use supported MRS exports. Stash retains YAML providers for compatibility. Loon and QuanX use native text exports in their platform directories. See [rule provenance](../rule/SOURCES.md).

MRS can compact duplicate suffixes and merge IP ranges, so decoded counts need not equal source counts.

## Groups

Business destinations are REJECT, DIRECT, LocalFly and ForeignFly. LocalFly allows TW/HK/JP/SG; ForeignFly allows SG/JP/US. Visible groups are Auto_HK, Auto_TW, Auto_JP, Auto_SG and Auto_US, with 600-second checks and 80 ms switching tolerance.

In Mihomo profiles, ForeignFly-AUTO uses ordered SG-to-JP-to-US fallback; each region uses latency selection. Loon and QuanX have different native behavior documented in their READMEs. Process rules only work where the client can identify the originating process, not on a bypass router observing Windows traffic.

## Conversion

Run from the public repository root with a compatible Mihomo executable:

~~~text
mihomo convert-ruleset domain yaml Clash/rule/Special.yaml Clash/mrs/Special.mrs
~~~

Classical DOMAIN, DOMAIN-SUFFIX and IP-CIDR entries must first be normalized to plain domain/IP payloads. Local conversion tooling is maintained outside the public Git repository.

## Match Data And Policies

Rule providers contain match conditions; the main profile selects the resulting policy. Full YAML profiles can additionally define nodes, DNS and groups.

| Format | Supported Match Data |
| --- | --- |
| YAML, domain behavior | Exact domains, suffixes and supported wildcards |
| YAML, ipcidr behavior | IPv4/IPv6 prefixes |
| YAML, classical behavior | Domains, regex, keywords, IPs, processes, ports and supported logical rules |
| MRS, domain behavior | Compressed domain match data |
| MRS, ipcidr behavior | Compressed IP prefixes |

Each MRS file has one behavior. Mixed domain/IP rules can be split into separate binary files or retained as classical YAML. Google and Telegram remain merged YAML; Domestic remains a mixed provider, while DomesticIP is independent.
