Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = "https://github.com/transifex/cli/releases/latest"

function global:au_SearchReplace {
  @{
    '.\legal\VERIFICATION.txt'        = @{
      '(?i)(^\s*location on\:?\s*)\<.*\>' = "`$1<$($Latest.ReleaseUrl)>"
      '(?i)(\s*64\-Bit Software.*)\<.*\>' = "`$1<$($Latest.URL64)>"
      '(?i)(\s*32\-Bit Software.*)\<.*\>' = "`$1<$($Latest.URL32)>"
      '(?i)(^\s*checksum32\:).*'          = "`$1 $($Latest.Checksum32)"
      '(?i)(^\s*checksum64\:).*'          = "`$1 $($Latest.Checksum64)"
      '(?i)(^\s*checksum\s*type\:).*'     = "`$1 $($Latest.ChecksumType64)"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      '(?i)(?<=^\s*\<releaseNotes\>)[^<]*(?=\<\/releaseNotes\>)' = $($Latest.ReleaseUrl)
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease transifex cli

  @{
    URL64      = $LatestRelease.assets | Where-Object { $_.name -eq "tx-windows-amd64.zip" } | Select-Object -ExpandProperty browser_download_url
    URL32      = $LatestRelease.assets | Where-Object { $_.name -eq "tx-windows-386.zip" } | Select-Object -ExpandProperty browser_download_url
    Version    = $LatestRelease.tag_name.TrimStart("v")
    ReleaseUrl = $LatestRelease.html_url
  }
}

update -ChecksumFor none
