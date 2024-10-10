﻿Import-Module Chocolatey-AU

$releases = 'http://www.cgsecurity.org/wiki/TestDisk_Download'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

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

  $re = 'testdisk\-[\d\.]+\.win\.zip$'
  $url32 = $download_page.Links | Where-Object href -match $re | Select-Object -first 1 -expand href

  $verRe = '[-]|\.win'
  $version32 = $url32 -split "$verRe" | Select-Object -last 1 -skip 1

  @{
    URL32 = $url32 -replace '\/Download_and_donate\.php'
    Version = $version32
    ReleaseNotes = "http://www.cgsecurity.org/wiki/TestDisk_${version32}_Release"
  }
}

try {
  update -ChecksumFor none
} catch {
  $ignore = "Unable to connect to the remote server"
  if ($_ -match $ignore) { Write-Host $ignore; 'ignore' } else { throw $_ }
}
