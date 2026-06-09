# MRS rules

Binary Mihomo rule sets generated from compatible YAML sources:

- `Local.mrs` from `rule/Local.yaml`
- `adblock.mrs` from `rule/adblock.yaml`

MRS generally loads faster and uses less storage and memory than YAML,
especially for large domain lists. Mihomo currently supports MRS only for
`domain` and `ipcidr` rule-provider behavior. Stash configurations therefore
continue to use YAML rules.

Regenerate with Mihomo:

```text
mihomo convert-ruleset domain yaml rule/Local.yaml mrs/Local.mrs
mihomo convert-ruleset domain yaml rule/adblock.yaml mrs/adblock.mrs
```
