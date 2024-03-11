Import-Module Chocolatey-AU
import-module "$PSScriptRoot\..\..\extensions\extensions.psm1"

$releases = 'https://www.poweriso.com/download.htm'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $re = 'PowerISO v([\d.]+)'
  $version = ($download_page.Content -split "`n") -match $re | Select-Object -first 1
  if ($version -match $re) { $version = $Matches[1] } else { throw "Can't find version" }
  $majorVersion = $version -replace "^(\d+).*$", '$1'

  @{
    Version = $version
    Url32   = "https://www.poweriso.com/PowerISO$majorVersion.exe"
    Url64   = "https://www.poweriso.com/PowerISO$majorVersion-x64.exe"
  }
}

update
