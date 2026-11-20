# Loon Profile And Resources

Use [hello_Loon.conf](../hello_Loon.conf) with Loon 3.5.3 build 1008+ or a compatible later release.

## Layout And Policies

- [rule](rule/): native lists exported from [shared YAML](../Clash/rule/).
- [module](module/): [device-loopback plugin](module/Loopback.loon.lpx).
- [Shared icons and attribution](../icon/README.md).

Business destinations are REJECT, DIRECT, LocalFly and ForeignFly. Five Auto region groups test every 600 seconds. LocalFly combines TW/HK/JP/SG; ForeignFly allows SG/JP/US.

ForeignFly-AUTO is a flattened fallback list ordered SG, JP, US. It selects the first available candidate, not necessarily the lowest-latency node within the preferred region. Selecting an Auto region explicitly uses regional latency selection.

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

Public subscriptions are disabled placeholders. Private profiles remain outside Git. Preserve upstream attribution; references are not security endorsements or licenses for unrelated code.
