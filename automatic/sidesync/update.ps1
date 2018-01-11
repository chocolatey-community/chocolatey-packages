import-module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'http://www.samsung.com/global/download/Sidesyncwin'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"         = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*fileType\s*=\s*)('.*')"    = "`$1'$($Latest.FileType)'"
    }
  }
}

function global:au_GetLatest {
  $url = Get-RedirectedUrl $releases
  $version = $url -split '_|.exe' | select -Last 1 -skip 1

  @{
    Version = $version
    URL32   = $url
    URL64   = $url
  }
}

update
