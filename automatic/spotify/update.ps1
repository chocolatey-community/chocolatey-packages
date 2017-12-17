Import-Module AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

$downloadUrl = 'https://download.spotify.com/SpotifyFullSetup.exe'

function global:au_SearchReplace {
  return @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function GetResultInformation([string]$url32) {
  $dest = "$env:TEMP\spotify.exe"
  Get-WebFile $url32 $dest | Out-Null
  $version = Get-Item $dest | % { $_.VersionInfo.ProductVersion -replace '^([\d]+(\.[\d]+){1,3}).*','$1' }

  $result = @{
    URL32 = $url32
    Version = $version
    Checksum32 = Get-FileHash $dest -Algorithm SHA512 | % Hash
    ChecksumType32 = 'sha512'
  }
  Remove-Item -Force $dest
  return $result
}

function global:au_GetLatest {

  if (($global:au_Force -ne $true) -and (Test-Path "$PSScriptRoot\info")) {
    $items = Get-Content "$PSScriptRoot\info" -Encoding UTF8 | select -First 1 | % { $_ -split '\|' }
    $headers = Get-WebHeaders $downloadUrl
    if ($items) {
      $etag = $items[0]
      $version = $items[1]
      if ($headers.ETag -ne $etag) {
        $result = GetResultInformation $downloadUrl
        "$($headers.ETag)|$($result.Version)" | Out-File "$PSScriptRoot\info" -Encoding utf8
      }
      else {
        $result = @{ URL32 = $url32 ; Version = $version }
      }
    }
    else {
      $result = GetResultInformation $downloadUrl
      "$($headers.ETag)|$($result.Version)" | Out-File "$PSScriptRoot\info" -Encoding utf8
    }
  }
  else {
    $headers = Get-WebHeaders $downloadUrl
    $result = GetResultInformation $downloadUrl
    "$($headers.ETag)|$($result.Version)" | Out-File "$PSScriptRoot\info" -Encoding utf8
  }

  return $result
}

update -ChecksumFor none
