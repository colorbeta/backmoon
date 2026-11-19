# MRS rule mapping

`rule/` contains editable YAML sources. `mrs/` contains supported binary
domain and IP rule sets. MRS only supports `domain` and `ipcidr` behavior.

| YAML source in `rule/` | Binary files in `mrs/` | Notes | 策略 |
| --- | --- | --- | --- |
| `adblock.yaml` | `adblock.mrs` | Lite snapshot; clients fetch upstream directly | ADBLOCK → REJECT（默认，可选 DIRECT），上游 Lite 每 8 小时更新 |
| `ai.yaml` | `ai.mrs` | Exact domains and suffixes | AI → 新加坡 / 日本 / 美国 |
| `cnbank.yaml` | `cnbank.mrs` | Domain list | CNBANK → DIRECT（默认） |
| `CNDirect.yaml` | `CNDirect.mrs` | Domain list | DIRECT |
| `Domestic.yaml` | `Domestic.mrs` | Domain entries, followed by `rule/DomesticExtra.yaml` | DOMESTIC → DIRECT（默认） |
| `DomesticExtra.yaml` | YAML only | Generated keyword/IP remainder of `Domestic.yaml` | DOMESTIC → DIRECT（默认） |
| `DomesticIP.yaml` | `DomesticIP.mrs` | Classical IP prefixes normalized before conversion | DOMESTIC → DIRECT（默认） |
| `github.yaml` | `github.mrs` | Domain list | GITHUB → 日本优先 |
| `google.yaml` | YAML only | Merged Google domains, IPs, and FCM, using `GOOGLE` | GOOGLE → 新加坡 / 日本 / 美国，包含 FCM |
| `LanCIDR.yaml` | `LanCIDR.mrs` | IP list | SPECIAL → DIRECT（默认） |
| `Private.yaml` | `Private.mrs` | Domain list | SPECIAL → DIRECT（默认） |
| `Special.yaml` | `Special.mrs` | Domain list | SPECIAL → DIRECT（默认） |
| `steam.yaml` | `steam.mrs` | Domain list | STEAM → 香港优先，可选 DIRECT |
| `steam_cn.yaml` | `steam_cn.mrs` | Domain list | SPECIAL → DIRECT（默认） |
| `telegram.yaml` | `telegram.mrs` | Domain list | TELEGRAM → 新加坡优先 |
| `telegram_ip.yaml` | `telegram_ip.mrs` | IP list | TELEGRAM → 新加坡优先 |
| `tiktok.yaml` | `tiktok.mrs` | Domain suffixes | TIKTOK → 新加坡优先 |
| `Applications.yaml` | YAML only | Process names | SPECIAL → DIRECT（默认） |
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
