Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

function global:au_SearchReplace {
  @{
    '.\legal\VERIFICATION.txt' = @{
      '(?i)(^\s*location on\:?\s*)\<.*\>' = "`$1<$($Latest.ReleaseUrl)>"
      '(?i)(\s*64\-Bit Software.*)\<.*\>' = "`$1<$($Latest.URL64)>"
      '(?i)(^\s*checksum64\:).*'          = "`$1 $($Latest.Checksum64)"
      '(?i)(^\s*checksum\s*type\:).*'     = "`$1 $($Latest.ChecksumType64)"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      '(?i)(?<=^\s*\<releaseNotes\>)[^<]*(?=\<\/releaseNotes\>)' = $($Latest.ReleaseUrl)
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)'.*'"           = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)'.*'"      = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType\s*=\s*)'.*'"  = "`${1}'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease Enyium sem-reg-rs

  @{
    URL64      = $LatestRelease.assets | Where-Object { $_.name -eq "night-light.exe" } | Select-Object -ExpandProperty browser_download_url
    Version    = $LatestRelease.tag_name.TrimStart("v")
    ReleaseUrl = $LatestRelease.html_url
  }
}

update -ChecksumFor 64