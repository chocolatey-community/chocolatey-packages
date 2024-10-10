﻿Import-Module Chocolatey-AU

$releases = 'https://sourceforge.net/projects/scribus/files/scribus/'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1
  Remove-Item "$PSScriptRoot\tools\$($Latest.FileName32)"
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
      "(?i)(^\s*Url\s*=\s*)''"                    = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*Checksum\s*=\s*)''"               = "`${1}'$($Latest.Checksum32)'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\/[\d\.]+\/$'
  $builder = New-Object System.UriBuilder($releases)
  $builder.Path = $download_page.Links | Where-Object href -match $re | Select-Object -first 1 -expand href
  $releasesUrl = $builder.Uri.ToString()

  $download_page = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $re = '\.exe\/download$'
  $urls = $download_page.Links | Where-Object href -match $re | Select-Object -expand href

  $url32 = $urls | Where-Object { $_ -notmatch '\-x64' } | Select-Object -first 1
  $url64 = $urls | Where-Object { $_ -match '\-x64' } | Select-Object -first 1

  $verRe = '\/'
  $version32 = $url32 -split "$verRe" | Select-Object -last 1 -skip 2

  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version32
    FileType = 'exe'
  }
}

update -ChecksumFor none
