Import-Module AU

$releases = 'https://www.gimp.org/downloads/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'" = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re        = '\.exe$'
  $url32     = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { 'https:' + $_ }

  $verRe     = '[-](?:setup(?:\-[\d]*)?)?|\.exe$'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 2
  @{
    URL32    = $url32
    Version  = $version32
  }
}

update -ChecksumFor 32
