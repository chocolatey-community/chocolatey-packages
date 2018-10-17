Import-Module AU

$releases     = 'https://www.gomlab.com/gomplayer-media-player/'
$versions     = 'https://www.gomlab.com/gomplayer-media-player/?type=update'
$softwareName = 'GOM Player'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $verRe = '((?:\d+\.){2,3}\d+)'
  $Matches = $null
  $version_page = Invoke-WebRequest -Uri $versions -UseBasicParsing
  $version_page.Content -match $verRe | Out-Null
  $version32 = $Matches[1]

  @{
    URL32 = $url32
    Version = $version32
  }
}

update -ChecksumFor 32
