Import-Module AU
Import-Module "$PSScriptRoot\..\..\extensions\extensions.psm1"

$releases = 'https://www.apple.com/itunes/download/'
$softwareName = 'iTunes'

function global:au_BeforeUpdate {
  $checksumType = 'sha256'
  $Latest.ChecksumType32 = $Latest.ChecksumType64 = $checksumType

  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32 -Algorithm $checksumType
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64 -Algorithm $checksumType
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"    = "`${1}'$($Latest.PackageName)'"
      "(?i)(^\s*softwareName\s*=\s*)'.*'"   = "`${1}'$softwareName'"
      "(?i)(^\s*url\s*=\s*)'.*'"            = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*url64(bit)?\s*=\s*)'.*'"    = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)'.*'"       = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)'.*'"   = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)(^\s*checksum64\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType64\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType64)'"
      "(?i)(^[$]version\s*=\s*)'.*'"        = "`${1}'$($Latest.RemoteVersion)'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $download_page.Content -match "\<span\>iTunes\s*([\d]+\.[\d\.]+)" | Out-Null
  $version = $Matches[1]

  $url32 = $download_page.Links | ? href -match "iTunesSetup\.exe$" | select -First 1 -Expand href
  $url64 = $download_page.Links | ? href -match "iTunes64Setup\.exe$" | select -First 1 -Expand href

  @{
    URL32         = $url32
    URL64         = $url64
    Version       = $version
    RemoteVersion = $version
    PackageName   = 'iTunes'
  }
}

update -ChecksumFor none
