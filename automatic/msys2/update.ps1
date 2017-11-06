import-module au

$releases = 'http://repo.msys2.org/distrib'

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
    $re = '\.xz$'

    $download_page = Invoke-WebRequest -Uri "$releases/i686" -UseBasicParsing
    $url32 = $download_page.Links | ? href -match $re | select -Last 1 | % { "$releases/i686/" + $_.href }
    $version32 = $url32 -split '/|-|\.' | select -Last 1 -Skip 2

    $download_page = Invoke-WebRequest -Uri "$releases/x86_64" -UseBasicParsing
    $url64 = $download_page.Links | ? href -match $re | select -Last 1 | % { "$releases/x86_64/" + $_.href }
    $version64 = $url64 -split '/|-|\.' | select -Last 1 -Skip 2

    if ($version32 -ne $version64) { throw "x32 and x64 versions are not the same" }

    @{
        Version      = "$version32.0.0"
        URL32        = $url32
        URL64        = $url64
    }
}

update -ChecksumFor none
