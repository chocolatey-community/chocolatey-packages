[CmdletBinding()]
param($IncludeStream, [switch]$Force)
. "$PSScriptRoot\..\cmake.install\update.ps1"

function global:au_BeforeUpdate {
  $Latest.URL32 = $Latest.URL32_p
  $Latest.URL64 = $Latest.URL64_p
  $Latest.FileType = 'zip'
  Get-RemoteFiles -Purge -NoSuffix
}

update -ChecksumFor none -IncludeStream $includeStream -Force:$Force
