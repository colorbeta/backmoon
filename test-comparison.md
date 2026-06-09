# Configuration comparison

## Original local configuration

- Strengths: modern Mihomo features, compact anchors, `.mrs` rules, TUN/sniffer support, detailed service groups.
- Weaknesses: not reliably portable to Stash; public fake-IP range; exposed controller without a secret; subscription placeholder; GitHub-hosted `.mrs` rules may fail on first startup.

## ClashConnectRules/Self-Configuration

- Strengths: broad traditional Clash/Stash compatibility, many service groups, provider-based automatic selection.
- Weaknesses: very large configuration, many remote dependencies, public fake-IP range, several legacy/client-specific fields, and no locally controlled rule mirror.

## Platform configurations

- Uses separate platform files so DNS interception and TUN behavior match each client.
- Organizes routing into Special, ad blocking, AI, media, technology, domestic,
  TikTok, GeoIP CN, and Final categories.
- Uses `classical` YAML rule providers hosted in this repository instead of `.mrs`.
- Provides an independent `AI` policy group.
- Provides an independent `GOOGLE-FCM` policy group for Android push reliability.
- Provides global and regional `url-test` groups for large node collections.
- Blocks advertising domains using the locally mirrored 217heidai list.
- Sends `192.168.50.0/24` directly for home and office LAN access.
- Sends every unmatched connection through `PROXY`.
- Uses 600-second automatic health checks and Apple failover.
