
Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://www.zotero.org/download/client/dl?channel=release&platform=win-x64'

function global:au_GetLatest {
    $url64 = Get-RedirectedUrl -url $releases
    $url32 = Get-RedirectedUrl -url $releases.replace('-x64', '32')

    $version = $url64 -split '/' |
        Where-Object { $_ -match '^\d+\.\d[0-9.]*$' } |
        Select-Object -Last 1

    @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

function global:au_BeforeUpdate {
    $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64

    $Latest.ChecksumType32 = 'sha256'
    $Latest.ChecksumType64 = 'sha256'
}

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(^\s*x32\:).*" = "`${1} $($Latest.URL32)"
            "(?i)(^\s*x64\:).*" = "`${1} $($Latest.URL64)"
            "(?i)(^\s*checksum32\:).*" = "`${1} $($Latest.Checksum32)"
            "(?i)(^\s*checksum64\:).*" = "`${1} $($Latest.Checksum64)"
        }

        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]url32\s*=\s*)('.*')" = "`${1}'$($Latest.URL32)'"
            "(?i)(^[$]url64\s*=\s*)('.*')" = "`${1}'$($Latest.URL64)'"
            "(?i)(^[$]checksum32\s*=\s*)('.*')" = "`${1}'$($Latest.Checksum32)'"
            "(?i)(^[$]checksum64\s*=\s*)('.*')" = "`${1}'$($Latest.Checksum64)'"
        }
    }
}

update -ChecksumFor none

