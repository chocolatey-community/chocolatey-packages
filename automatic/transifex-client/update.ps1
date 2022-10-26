Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix -FileNameBase tx
  if (!(Test-Path "$PSScriptRoot\tools\x64")) {
    mkdir "$PSScriptRoot\tools\x64"
  }

  Move-Item "$PSScriptRoot\tools\$($Latest.FileName64)" "$PSScriptRoot\tools\x64\$($Latest.FileName64)"
}

function global:au_SearchReplace {
  @{
    '.\legal\VERIFICATION.txt'        = @{
      '(?i)(^\s*location on\:?\s*)\<.*\>' = "`${1}<$($Latest.ReleaseUrl)>"
      '(?i)(\s*64\-Bit Software.*)\<.*\>' = "`${1}<$($Latest.URL64)>"
      '(?i)(^\s*checksum\s*type\:).*'     = "`${1} $($Latest.ChecksumType64)"
      '(?i)(^\s*checksum64\:).*'          = "`${1} $($Latest.Checksum64)"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      '(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)' = "`${1}$($Latest.ReleaseUrl)`${2}"
    }
  }
}
function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease transifex transifex-client

  @{
    URL64      = $LatestRelease.assets | Where-Object {$_.name -eq "tx.py37-x64.exe"} | Select-Object -ExpandProperty browser_download_url
    Version    = $LatestRelease.tag_name.TrimStart("v")
    ReleaseUrl = $LatestRelease.html_url
  }
}

update -ChecksumFor none
