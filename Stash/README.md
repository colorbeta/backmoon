# Stash Profile And Optional Modules

Use [hello_Stash.yaml](../hello_Stash.yaml) for routing and [Clash/rule](../Clash/rule/) for shared sources. This directory contains optional Stash resources, not private nodes or account data.

See [cross-client recommended settings](../RECOMMENDED_SETTINGS.md) for default labels, concurrent connections, loopback and optional MITM settings.

## JD Price Prototype

- [JD_Price.stoverride](module/JD_Price.stoverride): standalone override with an embedded script; no remote script download required.
- [JD_Price.js](script/JD_Price.js): matching source for review and maintenance.
- Original authors credited by the supplied module: wf021325, githubdulong, mw418. The script header references [githubdulong/Script](https://github.com/githubdulong/Script).
- Both supplied script attachments were identical; one script handles capture and response modification.

This is an optional test version, not a device-verified release or part of the main routing profile. Embedded providers require Stash iOS 3.2.5+ or a compatible later version. No captured credentials or CA certificate are included.

## Setup

1. Import and enable the override in Stash.
2. Generate your own CA certificate, install and trust it in iOS, and enable MITM. Never install a shared private CA key.
3. Open the Manmanbuy app's account/Me page and wait for the credential-saved notification.
4. Visit a JD page matching in.m.jd.com/product/graphext followed by a numeric HTML filename.
5. Disable the override when not needed; avoid duplicate price-comparison overrides.

Only in.m.jd.com:443 and apapia-sqk-weblogic.manmanbuy.com:443 are declared for MITM. Captured Manmanbuy request data can include device/session identifiers stored in Stash persistent storage. Price queries send filtered parameters and product information to the original Manmanbuy HTTPS APIs. This is not offline price lookup.

The adaptation adds completion callbacks, removes full-credential notifications, handles form delimiters, escapes inserted HTML and preserves original pages on errors. Synthetic tests cover these flows. Native import, live APIs, TLS interception and JD display remain unverified. App updates, certificate pinning, anti-bot behavior or expired credentials can break it.

No membership-unlock functionality was added. Original attribution remains; this port does not grant a new license over upstream code. Never publish persistent storage, cookies, packet captures or CA private keys.

## Maintenance And References

Keep the source and embedded payload synchronized. No upstream auto-update is configured. The [Loon module reference](https://kelee.one/Tool/Loon/Lpx/JD_Price.lpx) was supplied as a screenshot and scripts, not a successfully downloaded plugin file.

- [Script providers](https://stash.wiki/en/script/manage-script)
- [Request/response scripts](https://stash.wiki/en/script/rewrite-requests)
- [Overrides](https://stash.wiki/en/configuration/override)
- [MITM](https://stash.wiki/en/http-engine/mitm)

Device-loopback routing is configured in the Stash app settings, not through an unverified YAML key.
