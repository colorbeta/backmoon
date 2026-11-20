# Loon Plugin Snapshots And Review

These ten snapshots come from [mihoyo-typ/KeleeOne, Loon branch](https://github.com/mihoyo-typ/KeleeOne/tree/Loon/Plugin). Original author metadata remains in the configuration files. Snapshots are not automatically synchronized with that branch. Source and published hashes, dependency URLs, review scope and default states are recorded in [REVIEW.json](REVIEW.json).

This is a static review, not a security certification. The retrieved plugins mostly date from 2025. App/API changes may make them ineffective. We could not fully inspect their kelee.one script/JQ dependencies; those plugins remain disabled as requested. Do not assume a readable plugin makes its external code safe.

| Plugin | Default | Review Notes |
| --- | --- | --- |
| BlockAdvertisers | Enabled | Inline rules/rewrites, overlapping Lite; narrow Pinduoduo MITM scope; possible compatibility effects |
| Loopback.loon | Enabled | Only 10.7.0.1 is reflected; no remote scripts or certificate |
| Weibo_intl_remove_ads | Enabled | Inline rewrites with narrow hosts; verify timeline/comment behavior |
| JD_Price | Enabled | Uses this repository's adapted price script; Manmanbuy account-page capture required |
| Amap_remove_ads | Disabled | External JS, navigation/location response access |
| AppleWeatherEnhancer | Disabled | External versioned bundles, third-party weather providers/API tokens and Apple QUIC restriction |
| JD_remove_ads | Disabled | External JS can see account/order responses |
| Bilibili_remove_ads | Disabled | External JS/JQ and binary modifications; membership-display and teen-mode changes removed |
| Weibo_remove_ads | Disabled | External JS can see account, message and timeline data |
| smzdm_remove_ads | Disabled | External JQ; also blocks a coupon-list page |
| Block_HTTPDNS | Disabled | Aggressive shared-IP/domain blocking and sensitive MITM; can break apps rather than reliably prevent all DNS bypass |

## Local Changes

- AppleWeatherEnhancer: removed two invalid bare IP lines after its MITM section. No API token was supplied. Its third-party provider choices are unchanged but inactive.
- Bilibili: removed explicit membership-status display rewriting and the teen-mode mock response. Disabled external bundles remain unreviewed and may contain other non-ad features.
- Block_HTTPDNS: removed an invalid 182.256.* address expression, an unqualified rewrite with no action, and an overly broad/noncanonical 118.89.204.198/23 block. Other aggressive rules remain inactive.
- JD_Price: replaced the inaccessible dependency with [the locally adapted script](../../Stash/script/JD_Price.js), fixed capture-query matching and increased the response timeout. That script supports Loon and Stash environments; synthetic tests do not establish live API or device compatibility.

## Activation And Privacy

All plugins are listed in both public and private Loon profiles. Generate, install and trust your own CA in Loon to use HTTPS rewriting. No CA material is included and upstream server certificate verification is not disabled. Targeted decrypted requests/responses can contain account, message, purchase or location data. Never publish tokens, CA keys, captures or persistent storage. Public weather API token placeholders are empty.

BlockAdvertisers is the first plugin, then the loopback plugin. Main-profile Special DIRECT entries are repeated locally so they take precedence over plugin rules as well as remote advertising lists. Avoid overlapping ad/script plugins when diagnosing failures. Blocking HTTPDNS is not a guarantee that every app obeys the configured DNS service.

The final traffic policy remains LocalFly, not DIRECT. No node-name exclusion filter was added in this change. Excluding metadata or special-purpose nodes changes candidate membership, not the fallback traffic policy.

No entire upstream repository was forked, and no new license is granted over upstream code. Preserve author attribution and applicable upstream terms. Review dependencies before enabling a disabled plugin; native app tests remain required for every plugin.
