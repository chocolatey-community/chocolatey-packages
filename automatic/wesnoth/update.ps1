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

  $streams = @{ }

  $reStreams = @{
    "stable" = @{ re = "\.exe\/download$"; suffix = "" }
    "beta" = @{ re = "\/files\/wesnoth\/.*\.exe\/download$"; suffix = "-beta" }
  }

  $reStreams.Keys | % {
    $value = $reStreams[$_]
    $url32 = $download_page.Links | ? href -match $value.re | select -first 1 -expand href

    $verRe = '[-]'
    $version32 = $url32 -split "$verRe" | select -last 1 -skip 1
    if ($value.suffix) { $version32 += $value.suffix }

    $fileName32 = $url32 -split '\/' | select -last 1 -skip 1

    $checksum_page = Invoke-WebRequest -Uri "https://files.wesnoth.org/releases/${fileName32}.sha256" -UseBasicParsing

    $checksum32 = $checksum_page -split ' ' | select -first 1

    $streams.Add($_,  @{
      URL32 = $url32
      Version = $version32
      Checksum32 = $checksum32
      ChecksumType32 = 'sha256'
    })
  }

  return @{ Streams = $streams }
}

update -ChecksumFor 32
