[CmdletBinding()]
param([switch] $Force)

Import-Module AU

$domain = 'https://www.gnu.org'
$releases = "${domain}/software/octave/news.html"

function global:au_BeforeUpdate {
  $checksumType = 'sha256'
  $Latest.ChecksumType64 = $Latest.ChecksumType32 = $checksumType

  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32 -Algorithm $checksumType
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64 -Algorithm $checksumType
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*32\-bit software.*)\<.*\>"  = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*64\-bit software.*)\<.*\>"  = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"       = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum32?\:).*"           = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"            = "`${1} $($Latest.Checksum64)"
    }

    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*\`$version\s*=\s*)('.*')"       = "`${1}'$($Latest.Version)'"
      "(?i)(^\s*Url\s*=\s*)('.*')"              = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*Url64\s*=\s*)('.*')"            = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*Checksum\s*=\s*)('.*')"         = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*Checksum64\s*=\s*)('.*')"       = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*ChecksumType\s*=\s*)('.*')"     = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)(^\s*ChecksumType64\s*=\s*)('.*')"   = "`${1}'$($Latest.ChecksumType64)'"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'octave-.*-released'
  $url = $download_page.links | ? href -match $re | % href | select -First 1

  $version = (Split-Path $url -Leaf).Split("-")[1].Replace(".zip", "")

  return @{
    Version     = $version
    URL32       = "https://ftp.gnu.org/gnu/octave/windows/octave-${version}-w32.zip"
    URL64       = "https://ftp.gnu.org/gnu/octave/windows/octave-${version}-w64.zip"
    ReleaseNotes= "${domain}${url}"
  }
}

update -ChecksumFor none -Force:$Force
