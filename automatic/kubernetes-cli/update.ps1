[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module AU

$releases = 'https://github.com/kubernetes/kubernetes/releases/latest'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>"   = "`${1}<$($Latest.ReleaseURL)>"
      "(?i)(^\s*32\-bit software.*)\<.*\>"  = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*64\-bit software.*)\<.*\>"  = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"       = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"         = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"            = "`${1} $($Latest.Checksum64)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

function global:au_GetLatest {
  $url = Get-RedirectedUrl $releases

  $version = $url -split '\/v' | select -last 1
  $majorVersion = $version.Substring(0, 3)

  $streams = @{}

  $streams.Add($majorVersion, @{
    Version     = $version
    URL32       = "https://dl.k8s.io/v${version}/kubernetes-client-windows-386.tar.gz"
    URL64       = "https://dl.k8s.io/v${version}/kubernetes-client-windows-amd64.tar.gz"
    ReleaseNotes= "https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-${majorVersion}.md#v$($version -replace '\.','')"
    ReleaseURL  = "$releases"
  })

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
