import-module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://www.mendeley.com/client/get/1/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
    ".\mendeley.nuspec" = @{
      "(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

function global:au_GetLatest {
  $url = Get-RedirectedUrl $releases

  $version = $url -split '-' | select -Last 1 -skip 1

  @{
    Version = $version
    URL32   = $url
    ReleaseNotes = "https://www.mendeley.com/release-notes/v$($version -replace '\.','_')"
  }
}

update -ChecksumFor 32
