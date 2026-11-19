# MRS rule mapping

`rule/` contains editable YAML sources. `mrs/` contains supported binary
domain and IP rule sets. MRS only supports `domain` and `ipcidr` behavior.

| YAML source in `rule/` | Binary files in `mrs/` | Notes | 策略 |
| --- | --- | --- | --- |
| `adblock.yaml` | `adblock.mrs` | Lite snapshot; clients fetch upstream directly | REJECT，Lite 每 8 小时更新 |
| `ai.yaml` | `ai.mrs` | Exact domains and suffixes | ForeignFly（新加坡 / 日本 / 美国） |
| `Domestic.yaml` | YAML only | Unified domestic AI, banks, domains, keywords, and direct IP exceptions | DIRECT |
| `DomesticIP.yaml` | `DomesticIP.mrs` | Classical IP prefixes normalized before conversion | DIRECT |
| `github.yaml` | YAML only | Domains and anchored suffix regex | LocalFly（台湾 / 香港 / 日本 / 新加坡） |
| `google.yaml` | YAML only | Merged Google domains, IPs, and FCM, using `ForeignFly` | ForeignFly（新加坡 / 日本 / 美国） |
| `LanCIDR.yaml` | `LanCIDR.mrs` | IP list | DIRECT |
| `Private.yaml` | `Private.mrs` | Domain list | DIRECT |
| `Special.yaml` | `Special.mrs` | Domain list | DIRECT |
| `steam.yaml` | `steam.mrs` | Domain list | LocalFly（台湾 / 香港 / 日本 / 新加坡） |
| `steam_cn.yaml` | `steam_cn.mrs` | Domain list | DIRECT |
| `telegram.yaml` | YAML only | Merged domains, regex, and IP ranges | LocalFly（台湾 / 香港 / 日本 / 新加坡） |
| `tiktok.yaml` | `tiktok.mrs` | Domain suffixes | LocalFly（台湾 / 香港 / 日本 / 新加坡） |
| `Applications.yaml` | YAML only | Process names | DIRECT |
| `apple.yaml` | YAML only | Domains, keywords, IPs, and process names | LocalFly（台湾 / 香港 / 日本 / 新加坡） |
| `DomesticMedia.yaml` | YAML only | Domains and process names | DIRECT |
| `ForeignMedia.yaml` | YAML only | Domains, keywords, and process names | LocalFly（台湾 / 香港 / 日本 / 新加坡） |
| `Technology.yaml` | YAML only | Domains, keywords, IPs, and process names | LocalFly（台湾 / 香港 / 日本 / 新加坡） |

OpenClash, FlClash, and Ubuntu templates use supported MRS files.
Stash templates keep YAML providers for older-client compatibility.
Private variants use MRS for AI and TikTok where supported.
MRS compacts duplicate suffixes and merges IP ranges, so decoded entry counts
need not equal source entry counts.

规则出口统一为 `REJECT`、`DIRECT`、`LocalFly`、`ForeignFly`。
两个 Fly 组使用 select，可选自动模式或手动指定地区。香港、台湾、日本、
新加坡、美国五个地区组可查看节点状态，每 600 秒测速，切换容差为 80 毫秒。
默认自动模式由隐藏的 LocalFly-AUTO / ForeignFly-AUTO 汇总相应地区组。
自动地区组命名为 Auto_HK、Auto_TW、Auto_JP、Auto_SG、Auto_US。
进程规则适用于能识别该进程的设备，在旁路由上无法按 Windows 进程名识别转发流量。

Pure domain payloads can be converted with Mihomo:

```text
mihomo convert-ruleset domain yaml rule/Special.yaml mrs/Special.mrs
```

Classical DOMAIN / DOMAIN-SUFFIX / IP-CIDR syntax must be normalized to domain
or IP payloads before conversion. `Domestic.yaml` is a mixed classical
provider and is maintained as YAML. Local tooling and private configuration
files are maintained outside the published repository.

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
`Domestic.yaml` 统一维护国内 AI、银行和综合国内规则；`DomesticIP` 保留为独立 IP 库。
