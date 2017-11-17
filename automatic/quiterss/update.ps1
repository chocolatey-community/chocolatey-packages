import-module au

$releases = 'https://quiterss.org/en/download'

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url   = $download_page.links | ? href -match '.exe$' | select -First 1 -expand href
    $version = $url -split '-' | select -First 1 -Skip 1

    @{
        URL32   = 'https://quiterss.org' + $url
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
