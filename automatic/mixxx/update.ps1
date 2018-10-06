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
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    $re    = 'win..\.exe$'
    $url   = $download_page.links | ? href -match $re | select -First 2 -Expand href
    $version = $url[0] -split '/' | select -Last 1 -Skip 1
    @{  
        Version = $version.Replace('mixxx-', '')
        URL32   = $url | ? { $_ -like '*win32*' } | select -First 1
        URL64   = $url | ? { $_ -like '*win64*' } | select -First 1
    }
}

update -ChecksumFor none
