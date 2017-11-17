import-module au

$releases = 'https://www.videolan.org/vlc/download-windows.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*[$]fileType\s*=\s*)('.*')"  = "`$1'$($Latest.FileType)'"
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

function global:au_BeforeUpdate {
    rm tools\*.exe, tools\*.zip
    Get-RemoteFiles -NoSuffix
    if ($Latest.PackageName -eq 'vlc.portable') { rm tools\chocolateyUninstall.ps1 }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | % href
    $version  = $url[0] -split '-' | select -Last 1 -Skip 1

    $url32 = 'http:' + ( $url -match 'win32' | select -first 1 )
    $url64 = 'http:' + ( $url -match 'win64' | select -first 1 )
    $r = '\.exe$', '.zip'

    @{
        Streams = @{
          install  = @{ Version = $version; URL32 = $url32; URL64 = $url64 }
          portable = @{
              Version = $version; URL32 = $url32 -replace $r ; URL64 = $url64 -replace $r
              PackageName = 'vlc.portable'
          }
        }
    }
}

update -ChecksumFor none
