[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module AU

$domain   = 'https://github.com'
$releases = "$domain/coreos/etcd/releases"

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
  $urls = $download_page.links | ? href -match $re | % href

  $streams = @{}

  $urls | % {
    $version = $_ -split '\/v?' | select -last 1 -skip 1
    $majorVersion = $version -replace '^(\d+\.\d+).*',"`$1"

    if (!$streams.ContainsKey($majorVersion)) {
      $streams.Add($majorVersion, @{
        Version = $version
        URL64 = $domain + $_
        ReleaseURL = "$domain/coreos/etcd/releases/tag/v${version}"
      })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
