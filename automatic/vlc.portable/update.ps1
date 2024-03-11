Import-Module Chocolatey-AU
$releases = 'https://www.videolan.org/vlc/download-windows.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.7z$'
    $url   = $download_page.links | Where-Object href -match $re | ForEach-Object href
    $version  = $url -split '-' | Select-Object -Last 1 -Skip 1
    @{
        Version      = $version
        URL32        = 'http:' + $url
    }
}

update -ChecksumFor none
