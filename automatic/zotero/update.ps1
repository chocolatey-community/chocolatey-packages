Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://www.zotero.org/download/client/dl?channel=release&platform=win-x64'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  $version = $Latest.Version.ToString()

  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*32-bit download\:).*" = "`${1} $($Latest.URL32)"
      "(?i)(^\s*64-bit download\:).*" = "`${1} $($Latest.URL64)"
      "(?i)(^\s*32-bit checksum\:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*64-bit checksum\:).*" = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_GetLatest {
   $url64 = Get-RedirectedUrl -url $releases
   $url32 = $url64 -replace 'x64','win32'

   $version  = $url64.split('/') | Where-Object {$_ -match '^[0-9.]+$'}

   @{
      Version      = $version
      URL32        = $url32
      URL64        = $url64
   }
}

update -ChecksumFor none -force
