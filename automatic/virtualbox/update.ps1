import-module au

$releases = 'https://www.virtualbox.org/wiki/Downloads'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $url     = $download_page.links | ? href -match '\.exe' | % href
    $version = $url -split '/' | select -Last 1 -Skip 1

    @{ URL32 = $url; Version = $version }
}

$cert = ls cert: -Recurse | ? { $_.Thumbprint -eq 'a88fd9bdaa06bc0f3c491ba51e231be35f8d1ad5' }
if (!$cert) {
    Write-Host "Adding oracle certificate"
    certutil -addstore 'TrustedPublisher' "$PSScriptRoot\tools\oracle.cer"
}

update -ChecksumFor 32
