import-module au
import-module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

$domain   = 'https://github.com'
$releases = "$domain/rg3/youtube-dl/releases/latest"

function global:au_BeforeUpdate {
  if (Test-Path "$PSScriptRoot\tools") {
    Remove-Item "$PSScriptRoot\tools\*.exe" -Force
  } else {
    New-Item -ItemType Directory "$PSScriptRoot\tools"
  }
  $Latest.FileName = Get-WebFileName $Latest.URL32 'youtube-dl.exe'
  $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"
  Get-WebFile $Latest.URL32 $filePath

  # Let us check if the checksum actually matches
  $actualChecksum = Get-FileHash -Algorithm $Latest.ChecksumType32 $filePath | % Hash

  if ($actualChecksum -ne $Latest.Checksum32) {
    throw "The downloaded file do not match the provided checksum.`Actual Checksum is: $actualChecksum"
  }
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(listed on\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(1\..+)\<.*\>"          = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType32)"
      "(?i)(checksum:).*"       = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  $re    = '\.exe$'
  $url   = $domain + ($download_page.Links | ? href -match $re | select -First 1 -expand href)
  $filename = $url.Substring($url.LastIndexOf('/') + 1)
  $version  = $url -split '\/' | select -skip 1 -last 1

  $checksumAsset = $domain + ($download_page.Links | ? href -match "SHA2\-512SUMS$" | select -first 1 -expand href)
  $checksum_page = Invoke-WebRequest -Uri $checksumAsset
  $checksum = [regex]::Match($checksum_page, "([a-f\d]+)\s*$([regex]::Escape($filename))").Groups[1].Value

  return @{
    Version = $version
    URL32 = $url
    Checksum32 = $checksum
    ChecksumType32 = "sha512"
  }
}

update -ChecksumFor none
