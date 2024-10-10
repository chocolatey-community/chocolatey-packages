Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://www.maxthon.com/mx6/download/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
    }
  }
}

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.Url32
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\/mx\d+\/portable-formal-32\/dl'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href | % { Get-RedirectedUrl $_ }

  $verRe = '_|\.7z|\.zip$'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 2
  @{
    URL32        = $url32
    Version      = $version32
    ReleaseNotes = "http://www.maxthon.com/mx$($version32 -replace '^(\d+).*$','$1')/changelog/"
  }
}

update -ChecksumFor none
