﻿Import-Module Chocolatey-AU

$releases   = 'http://www.sparkleshare.org/'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
  try { $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases } catch { throw 'Downloading releases page failed' }

  $re    = 'sparkleshare.*\.msi$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

  $version  = $url -split '[-]|.msi' | select -Last 1 -Skip 1

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor none
