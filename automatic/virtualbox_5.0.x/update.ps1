. "$PSScriptRoot\..\virtualbox\update.ps1"

$releases = 'https://www.virtualbox.org/wiki/Download_Old_Builds_5_0'

function global:au_GetLatest {
  $Latest = GetLatest $releases
  $Latest.PackageName = 'virtualbox'
  $Latest
}

update -ChecksumFor 32
