import-module au
import-module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

$domain   = 'https://youtube-dl.org'
$releases = "$domain/"

function global:au_BeforeUpdate {
  if (Test-Path "$PSScriptRoot\tools") {
    Remove-Item "$PSScriptRoot\tools\*.exe" -Force
  } else {
    New-Item -ItemType Directory "$PSScriptRoot\tools"
  }
  $Latest.FileName = Get-WebFileName $Latest.URL32 'youtube-dl.exe'
  $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"
  Get-WebFile $Latest.URL32 $filePath
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
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re    = '\.exe$'
  $url   = $domain + "/" + ($download_page.Links | ? href -match $re | select -First 1 -expand href)
  $filename = $url.Substring($url.LastIndexOf('/') + 1)
  ($download_page.Content -match "\(v(2[0-9]{3}[.].*)\)")
  $version  = $Matches[1]
  
  #Update checksum automatically from self-contained executable
  $checksum = Get-RemoteChecksum -Algorithm "sha512" $url
  
  return @{
    Version = $version
    URL32 = $url
    Checksum32 = $checksum
    ChecksumType32 = "sha512"
  }
}

update -ChecksumFor none
