[CmdletBinding()]
param([switch] $Force)

Import-Module AU

$domain   = 'https://github.com'
$releases = "$domain/repos/kubernetes/minikube/releases/latest"

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
  $tags = Invoke-WebRequest $releases.Replace("https://github.com","https://api.github.com") -UseBasicParsing | ConvertFrom-Json

  $re = '\.exe$'
  $url = $tags[0].assets | Where-Object {$_.browser_download_url -match $re} | % browser_download_url | select -First 1

  $version = (Split-Path ( Split-Path $url ) -Leaf).Substring(1)

  return @{
    Version     = $version
    URL64       = "https://storage.googleapis.com/minikube/releases/v${version}/minikube-windows-amd64.exe"
    ReleaseNotes= "$domain/kubernetes/minikube/blob/v${version}/CHANGELOG.md"
    ReleaseURL  = "$domain/kubernetes/minikube/releases/tag/v${version}"
    PackageName = 'Minikube' # Casing is not in all lowercase on chocolatey.org
  }
}

update -ChecksumFor none -Force:$Force
