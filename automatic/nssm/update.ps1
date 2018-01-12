import-module au

$releases = 'https://www.nssm.cc/download'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}
function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re  = 'release.+\.zip$'
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url = "https://www.nssm.cc${url}"
    $version = $url -split '-|\.zip' | select -Last 1 -Skip 1

    $re_pre = '/ci.+\.zip$'
    $url_pre = $download_page.links | ? href -match $re_pre | select -First 1 -expand href
    $url_pre = "https://www.nssm.cc${url_pre}"
    $version_pre = ($url_pre -split '/' | select -last 1) -replace '^nssm-' -replace '-[^-]+$' -replace '-','.'
    $suffix = $url_pre -split '-|\.zip' |select -Last 1 -Skip 1

    if ([version]$version_pre -gt [version]$version) {
        @{
            Version = $version_pre
            URL32   = $url_pre
        }
    } else {
        @{
            Version = $version
            URL32   = $url
        }
    }
}

update -ChecksumFor none
