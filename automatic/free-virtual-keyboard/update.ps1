Import-Module AU

$releases = 'http://freevirtualkeyboard.com'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'" = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      "\<(releaseNotes)\>.*\<\/releaseNotes\>" = "<`$1>$($Latest.ReleaseNotes)</`$1>"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'Setup\.exe$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { $releases + $_ }

  $re = 'Version\:\s*\<\/span\>\s*([\d\.]+)'
  if ($download_page.Content -match $re) {
    $version = $Matches[1]
  }

  $re = 'free-virtual-keyboard.*\.html$'
  $releaseNotes = $download_Page.Links | ? href -match $re | select -first 1 -expand href

  @{
    URL32 = $url32
    Version = $version
    ReleaseNotes = $releaseNotes
  }
}

update -ChecksumFor 32
