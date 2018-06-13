import-module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://www.wps.com/download/?lang=en'
$padVersionUnder = '10.2.1'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]version\s*=\s*)('.*')"      = "`$1'$($Latest.Version)'"
      "(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
      "(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  if ($download_page.Content -match 'location="(https\:\/\/.*latest_package[^"]*)') {
    $url = $Matches[1]
    $urlRedirected = Get-RedirectedUrl $url
    $version = $urlRedirected -split '\/' | select -last 1 -skip 1
  }
  else {
    throw "Unable to grab installer url"
  }

  @{
    URL32   = $url
    Version = Get-FixVersion $version -OnlyFixBelowVersion $padVersionUnder
  }
}

update
