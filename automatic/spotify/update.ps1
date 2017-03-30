Import-Module AU

# We only use this for checking for Spotify versions, nothing else
$releasesUrl = 'http://www.filehorse.com/download-spotify/'
$downloadUrl = 'https://download.spotify.com/SpotifyFullSetup.exe'

function global:au_BeforeUpdate {
  # we need to verify that the downloaded file is the correct version
  Get-RemoteFiles -Purge
  $file = Get-Item "tools\*.exe" | select -First 1
  [version]$productVersion = $file.VersionInfo.ProductVersion -replace '([\d\.]+)\..*','$1'

  if ($productVersion -gt [version]$Latest.Version) {
    throw "New version is released, but not yet updated on filehorse"
  } elseif($productVersion -lt [version]$Latest.Version) {
    throw "filehorse shows a newer version than what is available officially"
  }

  Remove-Item $file -Force
}

function global:au_SearchReplace {
  return @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

# TODO: When forced, download the file and use the
# installer version, instead of parsing from filehorse

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl
  $re = 'Spotify ([\d]+\.[\d\.]+)'
  $version = $download_page.Content -match $re
  if ($Matches) {
    $version = $Matches[1]
  }

  return @{ Url32 = $downloadUrl; Version = $version }
}

update -ChecksumFor none
