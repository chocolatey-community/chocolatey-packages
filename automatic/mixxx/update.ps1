import-module au

$releases = 'http://www.mixxx.org/download'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
            "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
            "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
            "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | select -First 2
    $url32 = $url[0].href
    $url64 = $url[1].href

    $version = $url32 -split '/' | select -Last 1 -Skip 1
    $version = $version -split '-' | select -Last 1

    @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update -ChecksumFor none
