# Configuration comparison

## Original local configuration

- Strengths: modern Mihomo features, compact anchors, `.mrs` rules, TUN/sniffer support, detailed service groups.
- Weaknesses: not reliably portable to Stash; public fake-IP range; exposed controller without a secret; subscription placeholder; GitHub-hosted `.mrs` rules may fail on first startup.

## ClashConnectRules/Self-Configuration

- Strengths: broad traditional Clash/Stash compatibility, many service groups, provider-based automatic selection.
- Weaknesses: very large configuration, many remote dependencies, public fake-IP range, several legacy/client-specific fields, and no locally controlled rule mirror.

## Combined test configuration

- Uses conservative Clash-compatible fields shared by OpenClash/Mihomo, FlClash, and Stash.
- Uses `classical` YAML rule providers hosted in this repository instead of `.mrs`.
- Provides an independent `AI` policy group.
- Provides global and regional `url-test` groups for large node collections.
- Keeps client-specific TUN/sniffer settings out of the shared file; configure those in each client UI.
