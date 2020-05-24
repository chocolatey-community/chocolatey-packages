import-module au

$releases = 'https://github.com/msys2/msys2-installer/releases/latest'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $re64 = 'msys2-base-x86_64-(\d+)\.tar\.xz$'

    $baseUrl = $([System.Uri]$releases).Scheme + '://' + $([System.Uri]$releases).Authority

    $download_page = Invoke-WebRequest -Uri "$releases" -UseBasicParsing

    $url64 = $download_page.Links | ? href -match $re64 | select -First 1 | % { "$baseUrl" + $_.href }
    $version64 = [regex]::match($url64,$re64).Groups[1].Value

    @{
        Version      = "$version64.0.0"
        URL64        = $url64
    }
}

update -ChecksumFor none
