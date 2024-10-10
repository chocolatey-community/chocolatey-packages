﻿Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'http://optipng.sourceforge.net/'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameBase "optipng" }

function global:au_AfterUpdate {
  Update-ChangelogVersion -version $Latest.Version
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'win32\.zip[\?\/]download$'
  $url32 = $download_page.Links | Where-Object href -match $re | Select-Object -first 1 -expand href

  $verRe = '\-'
  $version32 = $url32 -split "$verRe" | Select-Object -last 1 -skip 1
  @{
    URL32 = $url32
    Version = $version32
    FileType = "zip"
    PackageName = 'OptiPNG'
  }
}

update -ChecksumFor none
