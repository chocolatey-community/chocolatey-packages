Import-Module AU

$domain   = 'http://www.joejoesoft.com'
$releases = "$domain/vcms/108/"

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.URL32 -Algorithm $Latest.ChecksumType32
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.zip$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href
  $fileName = $url32 -split '\/|\%2f' | select -Last 1
  $url32 = "http://files.snapfiles.com/directdl/$fileName"

  $Matches = $null
  $download_page.Content -match "Changes in v([\d\.]+)" | Out-Null
  if ($Matches) { $version = $Matches[1] }

  @{
    URL32 = $url32
    Version = $version
  }
}

update -ChecksumFor none
