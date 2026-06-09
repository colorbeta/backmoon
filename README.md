# backmoon

Platform-specific Mihomo/Clash configuration templates:

- `hello_openclash.yaml`: OpenWrt OpenClash. Enable DNS hijack in OpenClash.
- `hello_FlClash.yaml`: FlClash on Windows and Android, with TUN DNS hijack.
- `hello_Stash.yaml`: Stash on iOS, using Stash-compatible encrypted DNS.
- `hello_mihomo.yaml`: Mihomo on Ubuntu, with TUN DNS hijack.

Public templates contain only subscription placeholders. Private nodes,
subscription tokens, UUIDs, and keys belong under the ignored `local/`
directory and must never be uploaded.

All automatic node health checks run every 600 seconds. Unmatched traffic
uses `PROXY`.

See `PLATFORMS.md` for DNS-hijack and client setup notes.
