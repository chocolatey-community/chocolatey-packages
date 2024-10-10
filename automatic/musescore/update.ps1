﻿Import-Module Chocolatey-AU

$releases = 'https://musescore.org/en/download/musescore.msi'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -key "releaseNotes" -value $Latest.ReleaseNotes
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.msi$'
  $url32 = $download_page.Links | Where-Object href -match $re | Select-Object -first 1 -expand href

  $version32 = $url32 -split "-" | Select-Object -last 1 -skip 1
  @{
    URL32        = $url32
    Version      = $version32
    ReleaseNotes = "https://musescore.org/en/handbook/developers-handbook/release-notes/release-notes-musescore-$($version32 -replace '\..+')"
  }
}

update -ChecksumFor none
