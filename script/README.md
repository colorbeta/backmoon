# Reviewed Resource Parser Snapshot

Original author: KOP-XIAO (Shawn). Original copyright and embedded Base64
license notices remain in resource-parser.js. No additional license is granted.
Source: https://github.com/KOP-XIAO/QuantumultX/blob/master/Scripts/resource-parser.js
Retrieved 2026-11-19; upstream header reports 2026-11-02.
Upstream file SHA-256: 591852421bd935b4642a7af0f9a8c849fddf9ea7f4abd4326ea91d3f36e9acf2
Hardened Git blob: ffc13b74374b56a73f3ea449ea441b00e4878c21

This is a file snapshot in backmoon, not a fork of the entire upstream repository.
There is no scheduled update. Changes require another review and an update to
the local publication checker hash. Profiles use this repository's copy.

## Review Scope

Static inspection found no obvious active subscription-upload request, but this
is not proof of absence of vulnerabilities or a complete security audit.
The original optional sfilter/srename features execute decoded user-supplied
JavaScript with eval. Both execution sites now throw instead of evaluating
code; their existing handlers retain the unmodified node list. These features
are intentionally unsupported. Ordinary node conversion remains available.
Keep #cert=1 on subscription resources: some conversions otherwise disable
TLS certificate checking. Never disable checking to conceal a handshake error.

Notification hyperlinks/media and optional URL transformations remain upstream
features; clicking a subscription hyperlink or sending logs can disclose it.
Use trusted subscriptions and protect resource URLs and diagnostic logs.

Loon device loopback lives in module/Loopback.loon.lpx and only reflects
10.7.0.1. It can make on-device developer services reachable through that
virtual address; enable developer services only while needed. No remote
script, certificate, or listener is installed by this plugin.
Quantumult X 1.9.0 beta build 952 introduced reflected_routes in [general].
Source: the official channel https://t.me/s/QuanXNews, build 952 announcement.
Profiles enable reflected_routes = 10.7.0.1/32 and therefore require build 952+
of QX 1.9.0 or a compatible later release. Do not import them on older builds.
Loon include-tun/
IP Rewrite must not be copied into QX. DIRECT rules and DNS loopback rejection
are not substitutes for packet reflection. Actual sideloaded-tool compatibility
still requires testing on the device.
