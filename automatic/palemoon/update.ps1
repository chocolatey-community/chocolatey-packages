import-module au

$releasesx86 = 'https://www.palemoon.org/palemoon-win32.shtml'
$releasesx64 = 'https://www.palemoon.org/palemoon-win64.shtml'

function getReleaseInfo() {
  param([string]$releasesUrl)
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl

  $re = 'installer\.exe$'
  $url = $download_page.links | ? href -match $re | select -First 1 -expand href
  $version = $url -split '[-]|\.win[32|64]' | select -last 1 -skip 1;

  $download_page.content -match 'SHA-256\:\s*([a-f0-9]+)' | Out-Null
  $checksum = $Matches[1]

  return @{
    url = $url
    version = $version
    checksum = $checksum
  }
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_GetLatest {
  $x86Info = getReleaseInfo $releasesx86
  $x64Info = getReleaseInfo $releasesx64

  @{
    URL32 = $x86Info.url
    URL64 = $x64Info.url
    Checksum32 = $x86Info.checksum
    Checksum64 = $x64Info.checksum
    ChecksumType32 = 'sha256'
    ChecksumType64 = 'sha256'
    Version = $x86Info.version
  }
}

update -ChecksumFor none
