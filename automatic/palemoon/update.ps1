import-module au

$releasesx86 = 'https://www.palemoon.org/download.php?mirror=eu&bits=32&type=installer'
$releasesx64 = 'https://www.palemoon.org/download.php?mirror=eu&bits=64&type=installer'

function getReleaseInfo() {
  param([string]$releasesUrl)
  $url = Get-RedirectedUrl $releasesUrl

  $version = $url -split '[-]|\.win[32|64]' | select -last 1 -skip 1;

  return @{
    url = $url
    version = $version
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
    Version = $x86Info.version
  }
}

update
