# Loon Profile And Resources

Use [hello_Loon.conf](../hello_Loon.conf) with Loon 3.5.3 build 1008+ or a compatible later release.

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
