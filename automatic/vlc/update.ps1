import-module au
$releases = 'https://www.videolan.org/vlc/download-windows.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | % href
    $version  = $url[0] -split '-' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL32        = 'http:' + ( $url -match 'win32' | select -first 1 )
        URL64        = 'http:' + ( $url -match 'win64' | select -first 1 )
    }
}

update -ChecksumFor none
