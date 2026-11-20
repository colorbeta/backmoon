# QuanX 配置与参考项目

本目录保存 backmoon 的 Quantumult X 原生规则及资源解析器。完整配置位于仓库根目录的 [hello_QuantumultX.conf](../hello_QuantumultX.conf)。

## 当前设计

- 业务出口为 REJECT、DIRECT、LocalFly、ForeignFly，保留五个 Auto 地区组以查看与调整节点。
- 地区自动测速周期为 600 秒；ForeignFly 默认选择 Auto_SG，Auto_JP、Auto_US 供手动切换，不宣称具有跨地区自动顺序故障转移。
- 局域网和 Special 精确直连例外先于广告；专门服务先于国内、科技和最终兜底。GitHub 含 Copilot 使用 LocalFly，Google 与海外 AI 使用 ForeignFly，国内 AI 直连。
- Apple/微软的指定更新与下载端点在 Special 直连，普通服务仍按原分类处理。没有整域放行公共 CDN。
- 默认启用加密 DNS、no-system、no-ipv6；这些设置不能替代真机 DNS 路径验证。
- 已启用设备回环参数，要求 Quantumult X 1.9.0 build 952+ 或兼容的后续版本；不要直接导入旧版本。
- 重写、任务和 HTTP Backend 当前为空，不默认启用第三方脚本或 MITM。

## 参考与致谢

下表区分配置设计参考、实际资源引用和代码快照。列出项目不代表完整复制、兼容性保证或安全背书。

| 项目 | 参考用途 | 本仓库处理 |
| --- | --- | --- |
| [crossutility/Quantumult-X](https://github.com/crossutility/Quantumult-X) | 官方配置段、策略和资源语法 | 作为原生格式依据，保留完整配置段；新功能同时核对官方更新说明 |
| [Quantumult X News](https://t.me/QuanXNews/434) | build 952 的 reflected_routes 更新 | 采用原生设备回环参数，并声明最低版本 |
| [KOP-XIAO/QuantumultX](https://github.com/KOP-XIAO/QuantumultX) | 节点资源格式转换 | 使用本仓库审阅加固快照，保留作者声明；禁用动态脚本筛选/改名，订阅启用证书校验 |
| [ddgksf2013/Profile](https://github.com/ddgksf2013/Profile) / [配置入口](https://ddgksf2013.top/Profile/QuantumultX.conf) | 原生资源布局、图标、国内登录的 Fake-IP 兼容例外 | 已参考；未导入其公共节点、功能解锁和广告重写脚本 |
| [enriquephl/QuantumultX_config](https://github.com/enriquephl/QuantumultX_config) | 精确例外优先、更新下载与普通服务分开 | 在既有 Special 内补充精确例外并按用途整理；未整体导入白名单、系统 DNS 例外或地区解锁策略 |
| [curtinp118/QuantumultX](https://github.com/curtinp118/QuantumultX) / [主配置](https://github.com/curtinp118/QuantumultX/blob/main/profile/QX_Config.conf) | 地区正负向筛选、可选目标地址哈希、手动诊断资源 | 仅评估，未新增上述策略或脚本；继续使用现有自动地区组和四类业务出口 |
| [217heidai/adblockfilters](https://github.com/217heidai/adblockfilters) | Lite 广告规则 | 当前配置直接引用其 QuanX 原生 Lite 规则 |
| [ClashConnectRules/Self-Configuration](https://github.com/ClashConnectRules/Self-Configuration)、[Loyalsoldier/clash-rules](https://github.com/Loyalsoldier/clash-rules)、[MetaCubeX/meta-rules-dat](https://github.com/MetaCubeX/meta-rules-dat) | 跨平台规则来源与分类参考 | 具体来源和维护记录见 [Clash 规则说明](../Clash/rule/SOURCES.md) |
| [aaANDkk/Qure_Style_SVG](https://github.com/aaANDkk/Qure_Style_SVG) | 图标资源参考 | 共享图标及署名见 [icon](../icon/) |

## 对 curtinp118 配置的评估

值得参考的是地区筛选排除歧义标签、手动诊断入口，以及将内容下载与地区相关接口分别处理。目标地址哈希可为同一目标提供较稳定的节点选择，但不是新加坡、日本、美国顺序故障转移，也不能保证一个服务的全部域名都使用同一出口。当前不改变现有策略。

未采用其大量独立服务组、默认公益订阅、全局 STUN/QUIC 限制和重写资源，也未复制证书、订阅或账户数据。该配置的部分 DNS 泄漏测试关键词被显式路由到代理；测试时需要观察真实上游查询路径，不能只凭测试网页看到的出口判定其他 App 无泄漏。此处记录的是人工比较，不是对其全部规则及脚本的安全审计。

## 目录与维护

- [rule](rule/)：QuanX 原生列表，由 [Clash/rule](../Clash/rule/) 的源规则导出。
- [script](script/)：固定的资源解析器副本；加固范围、来源哈希和限制见 [解析器说明](script/README.md)。更新需重新审阅，不自动拉取上游。
- 本地带节点配置位于仓库外的 mylocal，不参与 Git 同步；订阅地址、Cookie、抓包、CA 私钥和持久化账户数据不能放入公开目录。
- 本目录暂时没有独立的 QuanX 模块，因此不创建空 module 目录。需要重写时应单独验证，再按实际支持格式引用。
- 参考项目的许可证只约束各自内容，不会自动覆盖其他上游脚本或本仓库全部文件。保留原作者署名和许可说明；设计参考不表示整仓 Fork。

本说明核对日期：2026-11-20。网站和上游资源会变化，配置导入、节点握手、DNS 及回环仍需在实际设备验证。
