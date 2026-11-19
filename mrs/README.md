# MRS rule mapping

`rule/` contains editable YAML sources. `mrs/` contains supported binary
domain and IP rule sets. MRS only supports `domain` and `ipcidr` behavior.

| YAML source in `rule/` | Binary files in `mrs/` | Notes |
| --- | --- | --- |
| `adblock.yaml` | `adblock.mrs` | Domain list |
| `ai.yaml` | `ai.mrs` | Exact domains and suffixes |
| `cnbank.yaml` | `cnbank.mrs` | Domain list |
| `CNDirect.yaml` | `CNDirect.mrs` | Domain list |
| `Domestic.yaml` | `Domestic.mrs` | Domain entries, followed by `rule/DomesticExtra.yaml` |
| `DomesticExtra.yaml` | YAML only | Generated keyword/IP remainder of `Domestic.yaml` |
| `DomesticIP.yaml` | `DomesticIP.mrs` | Classical IP prefixes normalized before conversion |
| `github.yaml` | `github.mrs` | Domain list |
| `google.yaml` | `google.mrs` | Domain list |
| `google_fcm.yaml` | `google_fcm.mrs`, `google_fcm_ip.mrs` | Both use `GOOGLE-FCM` |
| `google_ip.yaml` | `google_ip.mrs` | IP list |
| `LanCIDR.yaml` | `LanCIDR.mrs` | IP list |
| `Private.yaml` | `Private.mrs` | Domain list |
| `Special.yaml` | `Special.mrs` | Domain list |
| `steam.yaml` | `steam.mrs` | Domain list |
| `steam_cn.yaml` | `steam_cn.mrs` | Domain list |
| `telegram.yaml` | `telegram.mrs` | Domain list |
| `telegram_ip.yaml` | `telegram_ip.mrs` | IP list |
| `tiktok.yaml` | `tiktok.mrs` | Domain suffixes |
| `Applications.yaml` | YAML only | Process names |
| `apple.yaml` | YAML only | Domains, keywords, IPs, and process names |
| `DomesticMedia.yaml` | YAML only | Domains and process names |
| `ForeignMedia.yaml` | YAML only | Domains, keywords, and process names |
| `Technology.yaml` | YAML only | Domains, keywords, IPs, and process names |

OpenClash, FlClash, and Ubuntu templates use supported MRS files.
Stash templates keep YAML providers for older-client compatibility.
`mylocal/config.yaml` uses MRS for AI, TikTok, and split FCM.
MRS compacts duplicate suffixes and merges IP ranges, so decoded entry counts
need not equal source entry counts.

Regenerate from the repository directory with PowerShell:

```powershell
./tools/convert-rules.ps1 -Mihomo ./local/mihomo-test-bin/mihomo-windows-amd64-compatible.exe
```

The script validates the repository's flat YAML payload format, normalizes
classical domain/IP rule syntax, and checks converter errors before publishing
each binary. Edit `Domestic.yaml` to maintain its generated
`DomesticExtra.yaml` remainder.
