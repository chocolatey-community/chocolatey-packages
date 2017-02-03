Import-Module AU

$releases     = 'https://wiki.wesnoth.org/Download'
$softwareName = 'Battle for Wesnoth*'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)(\-SoftwareName\s+)'.*'"       = "`${1}'$softwareName'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe\/download$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $verRe = '[-]'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 1

  $fileName32 = $url32 -split '\/' | select -last 1 -skip 1

  $checksum_page = Invoke-WebRequest -Uri "https://files.wesnoth.org/releases/${fileName32}.sha256" -UseBasicParsing

  $checksum32 = $checksum_page -split ' ' | select -first 1

  @{
    URL32 = $url32
    Version = $version32
    Checksum32 = $checksum32
    ChecksumType32 = 'sha256'
  }
}

update -ChecksumFor 32
