Import-Module AU
Import-Module "$PSScriptRoot\..\..\extensions\extensions.psm1"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

$releases = 'https://www.apple.com/itunes/download/'
$softwareName = 'iTunes'

function VerifyVersionAndReturnChecksum() {
  param($url, $remoteVersion, $checksumType)

  $tempLocation = [System.IO.Path]::GetTempFileName()

  Get-WebFile $url $tempLocation

  try {
    $item = Get-Item $tempLocation

    if (!$item.VersionInfo.ProductVersion.StartsWith($remoteVersion)) {
      throw "The current url does not supply itunes version $remoteVersion`nURL: $url"
    }

    return Get-FileHash $tempLocation -Algorithm $checksumType | % Hash
  } finally {
    Remove-item -Force $tempLocation
  }
}

function global:au_BeforeUpdate {
  $checksumType = 'sha256'
  $Latest.ChecksumType32 = $Latest.ChecksumType64 = $checksumType



  $Latest.Checksum32 = VerifyVersionAndReturnChecksum -url $Latest.URL32 `
                                                      -remoteVersion $Latest.RemoteVersion `
                                                      -checksumType $checksumType
  $Latest.Checksum64 = VerifyVersionAndReturnChecksum -url $Latest.URL64 `
                                                      -remoteVersion $Latest.RemoteVersion `
                                                      -checksumType $checksumType
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
