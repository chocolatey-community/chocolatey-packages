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
  $versionRegularExpression = 'V (?<version>[\d\.]+),'
  $version = ($download_page.Content -split "`n") -match $versionRegularExpression | Select-Object -first 1
  if ($version -match $versionRegularExpression) { $version = $Matches.version } else { throw "Can't find version" }

  $32bitDownloadUrlRegularExpression = 'PowerISO[^-]*\.exe'
  $64bitDownloadUrlRegularExpression = 'PowerISO.*-x64\.exe'

  $url32     = $download_page.links | Where-Object href -match $32bitDownloadUrlRegularExpression | Select-Object -First 1 -expand href
  $url64     = $download_page.links | Where-Object href -match $64bitDownloadUrlRegularExpression | Select-Object -First 1 -expand href

  @{
    Version = Get-ChocolateyNormalizedVersion $version
    Url32   = $url32
    Url64   = $url64
  }
}

update
