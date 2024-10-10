Import-Module Chocolatey-AU

$releases = 'https://quiterss.org/files/'

function global:au_GetLatest {
    $releases_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $available_versions = $releases_page.links | Where-Object {$_.title -and $_.title.TrimEnd('_') -as [version]} | Sort-Object {$_.title.TrimEnd('_') -as [version]}
    $latest_version_url = $releases.TrimEnd('/') + '/' + $available_versions[-1].href

    $download_page = Invoke-WebRequest -Uri $latest_version_url -UseBasicParsing
    $url   = $download_page.links | ? href -match '\.exe$' | Select-Object -First 1 -expand href
    $version = $url -split '-' | Select-Object -First 1 -Skip 1

    @{
        URL32   = $latest_version_url + $url
        Version = $version
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles  -Purge -NoSuffix }

function global:au_SearchReplace {
   @{
    ".\tools\chocolateyInstall.ps1" = @{
        "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
        }
    ".\legal\VERIFICATION.txt" = @{
        "(?i)(installer:).*"       = "`${1} $($Latest.URL32)"
        "(?i)(checksum:).*"        = "`${1} $($Latest.Checksum32)"
        "(?i)(type:).*"            = "`${1} $($Latest.ChecksumType32)"
        }
    }
}

update -ChecksumFor none
