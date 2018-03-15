[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module AU

$domain   = 'https://github.com'
$releases = "$domain/coreos/etcd/releases/latest"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseURL)>"
      "(?i)(^\s*software.*)\<.*\>"        = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum\:).*"            = "`${1} $($Latest.Checksum64)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseURL)`${2}"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '-windows-amd64\.zip$'
  $url = $download_page.links | ? href -match $re | % href | select -First 1

  $version = (Split-Path ( Split-Path $url ) -Leaf).Substring(1)
  $majorVersion = $version.Substring(0, 3)

  $streams = @{}

  $streams.Add($majorVersion, @{
    Version   = $version
    URL64     = $domain + $url
    ReleaseURL= "$domain/coreos/etcd/releases/tag/v${version}"
  })

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
