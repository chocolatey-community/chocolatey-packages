[CmdletBinding()]
param([switch] $Force)

Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix -FileNameBase "kompose"
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseURL)>"
      "(?i)(^\s*software.*)\<.*\>"        = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum\:).*"            = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease kubernetes kompose

  return @{
    Version     = $LatestRelease.tag_name.TrimStart("v")
    URL64       = $LatestRelease.assets | Where-Object {$_.name.EndsWith(".exe")} | Select-Object -ExpandProperty browser_download_url
    ReleaseURL  = $LatestRelease.html_url
  }
}

update -ChecksumFor none -Force:$Force
