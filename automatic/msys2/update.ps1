import-module au

$releases = 'https://github.com/msys2/msys2-installer/releases/latest'

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
    $re32 = 'msys2-base-i686-(\d+)\.tar\.xz$'
    $re64 = 'msys2-base-x86_64-(\d+)\.tar\.xz$'

    $baseUrl = $([System.Uri]$releases).Scheme + '://' + $([System.Uri]$releases).Authority

    $download_page = Invoke-WebRequest -Uri "$releases" -UseBasicParsing
    $url32 = $download_page.Links | ? href -match $re32 | select -First 1 | % { "$baseUrl" + $_.href }
    $version32 = [regex]::match($url32,$re32).Groups[1].Value

    $url64 = $download_page.Links | ? href -match $re64 | select -First 1 | % { "$baseUrl" + $_.href }
    $version64 = [regex]::match($url64,$re64).Groups[1].Value

    if ($version32 -ne $version64) { throw "x32 and x64 versions are not the same" }

    @{
        Version      = "$version32.0.0"
        URL32        = $url32
        URL64        = $url64
    }
}

update -ChecksumFor none
