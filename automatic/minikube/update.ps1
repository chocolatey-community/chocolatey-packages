[CmdletBinding()]
param([switch] $Force)

Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix -FileNameBase "minikube"
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseURL)>"
      "(?i)(^\s*software.*)\<.*\>"        = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum\:).*"            = "`${1} $($Latest.Checksum64)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease kubernetes minikube

  return @{
    Version     = $LatestRelease.tag_name.TrimStart("v")
    URL64       = $LatestRelease.assets | Where-Object {$_.name -eq "minikube-windows-amd64.exe"} | Select-Object -ExpandProperty browser_download_url
    ReleaseNotes= "https://github.com/kubernetes/minikube/blob/$($LatestRelease.tag_name)/CHANGELOG.md"
    ReleaseURL  = $LatestRelease.html_url
    PackageName = 'Minikube' # Casing is not in all lowercase on chocolatey.org
  }
}

update -ChecksumFor none -Force:$Force
