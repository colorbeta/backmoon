param(
    [Parameter(Mandatory = $true)]
    [string]$Mihomo
)

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
$Mihomo = (Resolve-Path $Mihomo).Path
$temporaryDirectory = Join-Path ([IO.Path]::GetTempPath()) ('backmoon-mrs-' + [guid]::NewGuid().ToString('N'))
$null = New-Item -ItemType Directory -Path $temporaryDirectory
$utf8 = [Text.UTF8Encoding]::new($false)

function Read-Payload([string]$Name) {
    foreach ($line in [IO.File]::ReadAllLines((Join-Path $repository "rule/$Name.yaml"))) {
        $value = $line.Trim()
        if (!$value -or $value.StartsWith('#') -or $value -eq 'payload:') { continue }
        if (!$value.StartsWith('- ')) { throw "Unsupported YAML structure in $Name" }
        $value = $value.Substring(2).Trim()
        if ($value.StartsWith("'") -and $value.EndsWith("'")) {
            $value = $value.Substring(1, $value.Length - 2).Replace("''", "'")
        } elseif ($value.StartsWith('"') -and $value.EndsWith('"')) {
            throw "Double-quoted payload requires a YAML parser: $Name"
        }
        $value
    }
}

function Convert-Payload([string]$Name, [string]$Behavior, [string[]]$Payload) {
    if (!$Payload.Count) { throw "Empty payload: $Name" }
    $source = Join-Path $temporaryDirectory "$Name.yaml"
    $target = Join-Path $temporaryDirectory "$Name.mrs"
    $decoded = Join-Path $temporaryDirectory "$Name.txt"
    [IO.File]::WriteAllLines($source, @('payload:') + @($Payload | ForEach-Object { "  - '$_'" }), $utf8)
    $conversionLog = & $Mihomo convert-ruleset $Behavior yaml $source $target 2>&1
    if ($LASTEXITCODE -ne 0 -or $conversionLog -match 'invalid|empty rule') {
        throw "MRS conversion failed: $Name"
    }
    $null = & $Mihomo convert-ruleset $Behavior mrs $target $decoded
    if ($LASTEXITCODE -ne 0) { throw "MRS verification failed: $Name" }
    Copy-Item -LiteralPath $target -Destination (Join-Path $repository "mrs/$Name.mrs") -Force
    Write-Output "$Name ($Behavior): $($Payload.Count) source rules"
}

try {
    $domainSources = @('adblock', 'ai', 'cnbank', 'CNDirect', 'github', 'google', 'Private', 'Special', 'steam_cn', 'steam', 'telegram', 'tiktok')
    foreach ($name in $domainSources) {
        $payload = @(Read-Payload $name | ForEach-Object {
            if ($_ -match '^DOMAIN-SUFFIX,(.+)$') { '+.' + $Matches[1] }
            elseif ($_ -match '^DOMAIN,(.+)$') { $Matches[1] }
            elseif ($_ -match ',') { throw "Non-domain rule: $name" }
            else { $_ }
        })
        Convert-Payload $name 'domain' $payload
    }

    foreach ($name in @('DomesticIP', 'google_ip', 'LanCIDR', 'telegram_ip')) {
        $payload = @(Read-Payload $name | ForEach-Object {
            if ($_ -match '^IP-CIDR6?,([^,]+)(?:,no-resolve)?$') { $Matches[1] }
            elseif ($_ -match ',') { throw "Non-IP rule: $name" }
            else { $_ }
        })
        Convert-Payload $name 'ipcidr' $payload
    }

    $domestic = @(Read-Payload 'Domestic')
    $domains = @($domestic | ForEach-Object {
        if ($_ -match '^DOMAIN-SUFFIX,(.+)$') { '+.' + $Matches[1] }
        elseif ($_ -match '^DOMAIN,(.+)$') { $Matches[1] }
    })
    Convert-Payload 'Domestic' 'domain' $domains
    $extra = @($domestic | Where-Object { $_ -notmatch '^DOMAIN(?:-SUFFIX)?,' })
    [IO.File]::WriteAllLines((Join-Path $repository 'rule/DomesticExtra.yaml'), @('payload:') + @($extra | ForEach-Object { '  - ' + $_ }), $utf8)

    $fcm = @(Read-Payload 'google_fcm')
    $domains = @($fcm | ForEach-Object { if ($_ -match '^DOMAIN,(.+)$') { $Matches[1] } })
    $ips = @($fcm | ForEach-Object { if ($_ -match '^IP-CIDR6?,([^,]+)$') { $Matches[1] } })
    if ($domains.Count + $ips.Count -ne $fcm.Count) { throw 'Unexpected FCM rule type' }
    Convert-Payload 'google_fcm' 'domain' $domains
    Convert-Payload 'google_fcm_ip' 'ipcidr' $ips
} finally {
    # Only files created by this invocation exist in this unique directory.
    if (Test-Path -LiteralPath $temporaryDirectory) {
        Get-ChildItem -LiteralPath $temporaryDirectory -File | Remove-Item
        Remove-Item -LiteralPath $temporaryDirectory
    }
}
