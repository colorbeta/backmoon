# Loon Profile And Resources

Use [hello_Loon.conf](../hello_Loon.conf) with Loon 3.5.3 build 1008+ or a compatible later release.

See [cross-client recommended settings](../RECOMMENDED_SETTINGS.md), especially marked default differences and manual app-setting checks.

## Layout And Policies

- [rule](rule/): native lists exported from [shared YAML](../Clash/rule/).
- [module](module/): loopback and selected application plugins; see the [review and activation table](module/README.md).
- [Shared icons and attribution](../icon/README.md).

Business destinations are REJECT, DIRECT, LocalFly and ForeignFly. Five Auto region groups test every 600 seconds. LocalFly combines TW/HK/JP/SG; ForeignFly allows SG/JP/US.

ForeignFly-AUTO selects Auto_SG, Auto_JP, Auto_US in fallback order. Each region uses url-test with 600-second checks and 80 ms switching tolerance. Singapore's regional latency choice is preferred, then Japan and the US. Tolerance can retain a current node when another is only slightly faster. Native nested-policy behavior still needs device validation.

Keep Airport/edgetunnel aliases when replacing subscriptions. Add new subscription aliases to Remote Filter definitions. Local nodes need explicit group membership; regional names must match the filters.

## Loopback And DNS

The plugin includes only 10.7.0.1/32 in TUN and reflects it back to this device. It disables the IPv6 virtual interface and installs no remote script or CA certificate. Disable unneeded developer services. Sideloaded-tool compatibility requires device testing.

Encrypted DNS and IPv4-only mode are configured. Disable ordinary-DNS fallback in the app if that fallback is unwanted. App and operating-system settings remain relevant to privacy.

## References

- [Official examples](https://github.com/Loon0x00/LoonExampleConfig): native nodes, resources and groups.
- [General settings](https://nsloon.app/docs/General/), [plugins](https://nsloon.app/docs/Plugin/), [DNS](https://nsloon.app/docs/DNS/): configuration semantics.
- [Shared rule provenance](../Clash/rule/SOURCES.md): classification and rule origins.
- [217heidai/adblockfilters](https://github.com/217heidai/adblockfilters): native Loon Lite adblock list.
- [aaANDkk/Qure_Style_SVG](https://github.com/aaANDkk/Qure_Style_SVG): icon references, with retained notices in icon.
- [mihoyo-typ/KeleeOne reference profile](https://github.com/mihoyo-typ/KeleeOne/blob/Loon/Config/Loon_Sample_Configuration_By_iKeLee.lcf): reviewed the retrieved profile dated 2025-09-08 and credited to iKeLee; comparison only, not a complete import.
- [iKeLee recommended settings diagram](https://raw.githubusercontent.com/luestr/ProxyResource/main/Tool/Loon/Lcf/zh-CN/Resource/ConfigDiagram.png): visual app-settings reference, reviewed on 2026-11-20; summarized below, not redistributed here.

## Recommended App Settings Checklist

The linked diagram describes app UI settings. Importing a profile does not
necessarily apply these switches. Labels and locations can differ between
Loon builds. The following distinguishes the diagram from this repository's
choices; it is not a claim that the settings were applied to your device.

### Dashboard And Policy Display

- Use rule-based routing for normal operation.
- Dashboard shortcuts can be reordered with Edit. The diagram exposes Nodes,
  Request History, Captures, Script Tasks, DNS History, Plugins, Scripts, Rules,
  Rewrite, MitM, Network Sharing and Profiles. Visibility is optional.
- Dashboard status indicators for Scripts, Rewrite and MitM also act as
  switches. Larger shortcut tiles open the corresponding details pages.
- Keep Hide Automatic Groups off if you want to inspect Auto_HK/TW/JP/SG/US.
- The diagram enables Simple Mode and Hide Group Type Labels. Simple Mode
  hides subscription/script/resource icons, so leave it off if displaying
  icons is more important. Hiding group type labels is only a visual choice.

### Notifications

| Notification | Diagram Setting |
| --- | --- |
| Allow Notifications | On |
| Network Changes | On |
| Policy Configuration Errors | On |
| Subscription Node Updates | Off |
| Policy Configuration Changes | Off |
| Node Errors | On |
| Script Notifications | On |
| Memory Warnings | On |

These choices reduce routine update notifications while retaining useful
failure signals. Adjust them to preference; notifications are not leak guards.

### Advanced Network And DNS Settings

| Setting | Diagram Guidance | Treatment In This Project |
| --- | --- | --- |
| IP Mode | IPv4 Only | Already configured as v4-only |
| Network Interface | Auto | Keep the normal automatic interface choice |
| Do Not Use As Default Route | Off | Do not enable blindly; some traffic would bypass the VPN path |
| Disconnect On Policy Change | Off | Preserve existing sessions; a changed group may only affect new connections |
| Domain Rejection Stage | DNS | A reasonable choice for domain adblocking |
| DNS Rejection Response | LoopbackIP | This is an adblock DNS response, not device reflection for sideloading |
| SNI-Assisted Rule Matching | On | Already configured as sni-sniffing=true |
| Exclude Route 0.0.0.0/31 | Off | The diagram warns of a system issue; do not add this bypass |
| Proxy Mode | TUN Only | The diagram requires it for its DNS-stage blocking workflow |

The diagram shows private bypass-route lists, but this repository does not
copy them wholesale. Existing LAN routing and the narrow loopback plugin
remain in place. Keep encrypted DNS enabled and review ordinary-DNS fallback
in the app separately; the diagram is not a complete DNS privacy audit.

### UDP And Connectivity Checks

- The diagram enables Drop STUN When Direct and sets unsupported-UDP fallback
  to REJECT. Direct-STUN blocking can reduce some WebRTC address exposure but
  may affect calls or real-time applications. It does not prove anonymity.
- Our profile already uses udp-fallback-mode=REJECT. It keeps disable-stun=false
  for compatibility. The diagram's direct-only STUN switch and the general
  disable-stun setting should not be assumed to have identical scope.
- The diagram separates direct connectivity testing from proxy testing,
  enables TCP-handshake latency display and uses a 2-second timeout.
- Our profile separates the direct probe (wifi.vivo.com.cn) from the proxy
  probe (www.gstatic.com), retains a 5-second timeout and checks nodes every
  600 seconds. This avoids treating a slightly slow response as a failed node.
  TCP-handshake display is optional diagnostic information.

### Scripts, Rewrite And MitM

The diagram keeps Scripts, Rewrite and MitM enabled for its plugin workflow,
and enables MitM over HTTP/2 and QUIC fallback protection. For this repository:

1. Enable Scripts and Rewrite when using enabled plugins that require them.
2. Enable MitM only after generating, installing and trusting your own CA, and
   restrict interception to the enabled plugins' required hosts.
3. MitM over HTTP/2 and QUIC fallback protection are useful for compatible
   HTTPS-rewrite plugins. Do not interpret them as decrypting every app or as
   a reason to enable an unreviewed plugin.
4. Keep the disabled plugin list from [the review table](module/README.md).
   Global app switches do not replace per-plugin review or device testing.
5. Never publish a CA private key, account capture or persistent credential.

Pure domain-routing and DNS adblock rules do not require MitM. If no active
feature needs HTTPS rewriting, there is no requirement to leave MitM enabled.
The device-loopback plugin is independent of MitM and uses IP reflection.

## iKeLee Reference Review

The reference provides exclusion filters, a separate direct-network test URL,
and nested region selectors. The connectivity probe and regional foreign
fallback are now adopted. Node filters remain unchanged pending a clear naming
policy; excluding candidates does not require a DIRECT traffic fallback.
All requested plugin snapshots are listed, with unreviewed dependencies and
aggressive HTTPDNS rules disabled. See module/README.md for review details.

The 60-second probing schedule, system DNS baseline, hard-coded SSID, broad
TUN bypasses and fake-IP DIRECT entries were not adopted.
Plugin names alone do not establish DNS-leak protection. Current 600-second
checks, encrypted DNS, shared rule priorities and limited device-loopback
plugin remain unchanged. Additional parsers and plugins should only be added
for a demonstrated need after reviewing their scripts and network access.

Public subscriptions are disabled placeholders. Private profiles remain outside Git. Preserve upstream attribution; references are not security endorsements or licenses for unrelated code.
