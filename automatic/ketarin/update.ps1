Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
  $url32 = (Get-RedirectedUrl "https://ketarin.org/download") -split '\?' | select -first 1

  $verRe = '[-]|\.zip'
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 1
  @{
    URL32   = $url32 -replace 'http:','https:'
    Version = $version32
  }
}

update -ChecksumFor none
