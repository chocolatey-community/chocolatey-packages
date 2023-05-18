[CmdletBinding()]
param([switch] $Force)

import-module au

$releases = 'https://www.startallback.com/download.php'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
      "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
    }

    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^\s*[$]softwareNamePattern\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
    }
  }
}

function global:au_GetLatest {
  $response = Invoke-WebRequest -Uri $releases -MaximumRedirection 0 -ErrorAction SilentlyContinue -Method HEAD
  $url = $response.Headers.Location
  $version  = $url -split '_|_setup.exe' | Select-Object -Last 1 -Skip 1

  return @{
    Version      = $version
    URL32        = $url
  }
}

update -Force:$Force
