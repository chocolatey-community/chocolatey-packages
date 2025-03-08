Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://www.zotero.org/download/client/dl?channel=release&platform=win-x64'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*x32\:).*" = "`${1} $($Latest.URL32)"
      "(?i)(^\s*x64\:).*" = "`${1} $($Latest.URL64)"
      "(?i)(^\s*checksum32\:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*" = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]File32Name =).*" = "`${1} '$($Latest.URL32.split('/')[-1])'"
      "(?i)(^[$]File64Name =).*" = "`${1} '$($Latest.URL64.split('/')[-1])'"
    }
  }
}

function global:au_GetLatest {
   $url64 = Get-RedirectedUrl -url $releases
   $url32 = $url64 -replace 'x64','win32'

   $version  = $url64 -split '/' | Where-Object {$_ -match '^\d+\.\d[0-9.]*$'} | Select-Object -Last 1

   @{
      Version      = $version
      URL32        = $url32
      URL64        = $url64
   }
}

update -ChecksumFor none
