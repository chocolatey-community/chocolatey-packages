Import-Module Chocolatey-AU

$releases = 'https://wolicheng.com/womic/download.html'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"           = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`${1}'$($Latest.ChecksumType32)'"
    }
    ".\womic.nuspec" = @{
      "(\<version\>)[^\<]+(\</version\>)" = "`${1}$($Latest.Version)`${2}"
      "(\<releaseNotes\>)[^\<]+(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  # Extract version from the table: "Client version: 6.4 Driver version: 2.1.0.0"
  $version_match = $download_page.Content -match 'Client version:\s*([\d\.]+)'
  if (!$version_match) {
    throw "Could not find version on download page"
  }
  $version = $matches[1]

  # The download URL - construct from version
  $url32 = "https://wolicheng.com/womic/downloads/WOMicClientSetup$version.exe"

  # Get the checksum
  $checksum32 = Get-RemoteChecksum -Url $url32 -Algorithm 'sha256'

  return @{
    Version       = $version
    URL32         = $url32
    Checksum32    = $checksum32
    ChecksumType32 = 'sha256'
    ReleaseNotes  = "Client version: $version Driver version: 2.1.0.0"
  }
}

update -ChecksumFor 32 -NoCheckUrl