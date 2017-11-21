Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'http://www.maxthon.com/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\/mx[\d]+\/portable\/dl'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { Get-RedirectedUrl ('http://www.maxthon.com' + $_) }

  $verRe = '_|\.7z$'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 1
  @{
    URL32        = $url32 -replace 'http:', 'https:'
    Version      = $version32
    ReleaseNotes = "http://www.maxthon.com/mx$($version32 -replace '^(\d+).*$','$1')/changelog/"
  }
}

update -ChecksumFor 32
