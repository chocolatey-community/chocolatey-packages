[CmdletBinding()]
param([switch] $Force)

Import-Module AU

$releases = "https://ftp.gnu.org/gnu/octave/windows/?C=M;O=D"

function global:au_BeforeUpdate {
  $checksumType = 'sha256'
  $Latest.ChecksumType64 = $Latest.ChecksumType32 = $checksumType

  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32 -Algorithm $checksumType
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64 -Algorithm $checksumType
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*32\-bit software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*64\-bit software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"      = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum32?\:).*"          = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"           = "`${1} $($Latest.Checksum64)"
    }

    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*\`$version\s*=\s*)('.*')"     = "`${1}'$($Latest.Version)'"
      "(?i)(^\s*Url\s*=\s*)('.*')"            = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*Url64\s*=\s*)('.*')"          = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*Checksum\s*=\s*)('.*')"       = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*Checksum64\s*=\s*)('.*')"     = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*ChecksumType\s*=\s*)('.*')"   = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)(^\s*ChecksumType64\s*=\s*)('.*')" = "`${1}'$($Latest.ChecksumType64)'"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'octave-.*-.*w(64|32)\.7z$'
  $urls = $download_page.links | ? href -match $re | select -First 2 -expand href | % { New-Object uri([uri]$releases, $_) }

  $url32 = $urls -match "w32" | select -first 1
  $url64 = $urls -match "w64" | select -first 1

  $version32 = $url32 -split '[-]' | select -Last 1 -Skip 1
  $version64 = $url64 -split '[-]' | select -Last 1 -Skip 1

  if ($version32 -ne $version64) {
    throw "32bit and 64bit versions do not match. Please Investigate."
  }

  $releases_url = "https://www.gnu.org/software/octave/news.html"
  $releases_page = Invoke-WebRequest -Uri $releases_url -UseBasicParsing
  $re = 'octave-.*-released'
  $releaseNotes = $releases_page.links | ? href -match $re | select -First 1 -expand href | % { New-Object uri([uri]$releases_url, $_) }

  return @{
    Version      = $version32.Replace('_', '.')
    URL32        = $url32
    URL64        = $url64
    ReleaseNotes = "$releaseNotes"
  }
}

update -ChecksumFor none -Force:$Force
