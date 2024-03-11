[CmdletBinding()]
param([switch] $Force)

Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*64\-bit software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"      = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum(64)?\:).*"        = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease kubescape kubescape

  return @{
    Version        = $LatestRelease.tag_name.TrimStart("v")
    URL64          = $LatestRelease.assets | Where-Object {$_.name -eq 'kubescape.exe'} | Select-Object -ExpandProperty browser_download_url
  }
}

update -ChecksumFor none -Force:$Force
