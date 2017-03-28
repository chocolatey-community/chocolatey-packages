Import-Module AU

$global:downloadUrl = 'https://download.spotify.com/SpotifyFullSetup.exe'
$global:fileType = 'exe'
$global:checksumType = 'sha256'
$global:file = Join-Path . "\tools\$([System.IO.Path]::GetFileNameWithoutExtension($Latest.URL32))_x32.exe"

function global:au_SearchReplace {
  return @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]installer\s*=\s*)('.*')" = "`$1'$([System.IO.Path]::GetFileName($Latest.URL32))'"
      "(?i)(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $Latest.Url32 = $global:downloadUrl
  $Latest.FileType = $global:fileType
  $Latest.ChecksumType32 = $global:checksumType

  Get-RemoteFiles

  if (Test-Path $global:file) {
    $Latest.Checksum32 = (Get-FileHash $global:file -Algorithm $global:checksumType | ForEach Hash).ToLowerInvariant()

    $versionInfo = (Get-Item $global:fileName).VersionInfo
    $stableVersion = $versionInfo.ProductVersion -replace '([0-9\.]+)\..*', '$1'

    Remove-Item $global:file -Force
  }

  return @{ Url32 = $Latest.Url32; Version = $stableVersion }
}

update -ChecksumFor none
