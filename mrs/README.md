# MRS rules

Binary Mihomo rule sets generated from compatible YAML sources:

- `Special.mrs` from `rule/Special.yaml`
- `Private.mrs` from `rule/Private.yaml`
- `LanCIDR.mrs` from `rule/LanCIDR.yaml`
- `Domestic.mrs` from the domain entries in `rule/Domestic.yaml`
- `DomesticIP.mrs` from the IP entries in `rule/DomesticIP.yaml`
- `adblock.mrs` from `rule/adblock.yaml`
- `ai.mrs` from the merged `rule/ai.yaml`

MRS generally loads faster and uses less storage and memory than YAML,
especially for large domain lists. Mihomo currently supports MRS only for
`domain` and `ipcidr` rule-provider behavior. Stash configurations therefore
continue to use YAML rules.

Regenerate with Mihomo:

```text
mihomo convert-ruleset domain yaml rule/Special.yaml mrs/Special.mrs
mihomo convert-ruleset domain yaml rule/Private.yaml mrs/Private.mrs
mihomo convert-ruleset ipcidr yaml rule/LanCIDR.yaml mrs/LanCIDR.mrs
mihomo convert-ruleset domain yaml rule/adblock.yaml mrs/adblock.mrs
mihomo convert-ruleset domain yaml rule/ai.yaml mrs/ai.mrs
```
