# MRS rule mapping

`rule/` contains editable YAML sources. `mrs/` contains supported binary
domain and IP rule sets. MRS only supports `domain` and `ipcidr` behavior.

| YAML source in `rule/` | Binary files in `mrs/` | Notes | 策略 |
| --- | --- | --- | --- |
| `adblock.yaml` | `adblock.mrs` | Lite snapshot; clients fetch upstream directly | ADBLOCK → REJECT（默认，可选 DIRECT），上游 Lite 每 8 小时更新 |
| `ai.yaml` | `ai.mrs` | Exact domains and suffixes | AI → 新加坡 / 日本 / 美国 |
| `cnbank.yaml` | YAML only | Domains and anchored suffix regex | DIRECT |
| `CNDirect.yaml` | `CNDirect.mrs` | Domain list | DIRECT |
| `Domestic.yaml` | `Domestic.mrs` | Domain entries, followed by `rule/DomesticExtra.yaml` | DOMESTIC → DIRECT（默认） |
| `DomesticExtra.yaml` | YAML only | Generated keyword/IP remainder of `Domestic.yaml` | DOMESTIC → DIRECT（默认） |
| `DomesticIP.yaml` | `DomesticIP.mrs` | Classical IP prefixes normalized before conversion | DOMESTIC → DIRECT（默认） |
| `github.yaml` | YAML only | Domains and anchored suffix regex | GITHUB → 台湾 → 香港 → 日本 → 新加坡 |
| `google.yaml` | YAML only | Merged Google domains, IPs, and FCM, using `GOOGLE` | GOOGLE → 新加坡 / 日本 / 美国，包含 FCM |
| `LanCIDR.yaml` | `LanCIDR.mrs` | IP list | DIRECT |
| `Private.yaml` | `Private.mrs` | Domain list | DIRECT |
| `Special.yaml` | `Special.mrs` | Domain list | DIRECT |
| `steam.yaml` | `steam.mrs` | Domain list | STEAM → 台湾 → 香港 → 日本 → 新加坡 |
| `steam_cn.yaml` | `steam_cn.mrs` | Domain list | DIRECT |
| `telegram.yaml` | YAML only | Merged domains, regex, and IP ranges | TELEGRAM → 台湾 → 香港 → 日本 → 新加坡 |
| `tiktok.yaml` | `tiktok.mrs` | Domain suffixes | TIKTOK → 台湾 → 香港 → 日本 → 新加坡 |
| `Applications.yaml` | YAML only | Process names | DIRECT |
| `apple.yaml` | YAML only | Domains, keywords, IPs, and process names | APPLE → 香港 → 日本 → 新加坡 → 美国 |
| `DomesticMedia.yaml` | YAML only | Domains and process names | DOMESTIC-MEDIA → DIRECT（默认） |
| `ForeignMedia.yaml` | YAML only | Domains, keywords, and process names | FOREIGN-MEDIA → AUTO（默认） |
| `Technology.yaml` | YAML only | Domains, keywords, IPs, and process names | TECHNOLOGY → AUTO（默认，可选 DIRECT） |

OpenClash, FlClash, and Ubuntu templates use supported MRS files.
Stash templates keep YAML providers for older-client compatibility.
`mylocal/config.yaml` uses MRS for AI and TikTok.
MRS compacts duplicate suffixes and merges IP ranges, so decoded entry counts
need not equal source entry counts.

策略列表示当前模板的初始选项。客户端保存的手动选择优先于初始选项。
进程规则适用于能识别该进程的设备，在旁路由上无法按 Windows 进程名识别转发流量。

Regenerate from the repository directory with PowerShell:

```powershell
./tools/convert-rules.ps1 -Mihomo ./local/mihomo-test-bin/mihomo-windows-amd64-compatible.exe
```

The script validates the repository's flat YAML payload format, normalizes
classical domain/IP rule syntax, and checks converter errors before publishing
each binary. Edit `Domestic.yaml` to maintain its generated
`DomesticExtra.yaml` remainder.

## Rule types and policies

规则文件保存匹配条件，主配置的 `rules` 决定匹配后走 `DIRECT`、
`REJECT` 或哪个策略组。完整 YAML 主配置还可定义节点、DNS 和策略组。

| 规则文件形式 | 可保存的匹配条件 |
| --- | --- |
| YAML + `behavior: domain` | 域名、域名后缀及受支持的域名通配 |
| YAML + `behavior: ipcidr` | IPv4 / IPv6 地址段 |
| YAML + `behavior: classical` | 域名、正则、关键词、IP、进程、端口及内核支持的逻辑规则 |
| MRS + `behavior: domain` | 压缩的域名匹配数据 |
| MRS + `behavior: ipcidr` | 压缩的 IPv4 / IPv6 地址段 |

MRS 的一个文件只能声明一种 behavior。域名和 IP 混合时可拆成两份 MRS，
也可合为一份 classical YAML。包含 `DOMAIN-REGEX`、`PROCESS-NAME` 等
条件的集合使用 classical YAML。当前 Google、Telegram 采用合并 YAML。
`Domestic.mrs` 与 `DomesticExtra.yaml` 共同保留原始国内规则的全部条件。
