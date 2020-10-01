import-module au

$releases = 'https://www.gyan.dev/ffmpeg/builds'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_GetLatest {
  $urlPre = "$releases/packages/"
  $download_page = Invoke-WebRequest -Uri "$releases/packages/" -UseBasicParsing -Header @{ Referer = $releases }
  $version       = $download_page.links | ? href -match 'essentials_build\.(zip|7z)$' | % { $_.href -split '-' | select -Index 1} | ? { $__=$null; [version]::TryParse($_, [ref] $__) } | sort -desc | select -First 1
  $url64         = $download_page.links | ? href -match "\-${version}\-.*\-essentials_build.*"  | % href | Select -Last 1 | % { $urlPre + $_ }

  @{ URL64=$url64; Version = $version }
}

update -ChecksumFor none
