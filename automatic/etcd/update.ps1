[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module AU

$domain = 'https://github.com'
$releases = "$domain/etcd-io/etcd/releases"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseURL)>"
      "(?i)(^\s*software.*)\<.*\>"        = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum\:).*"            = "`${1} $($Latest.Checksum64)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<copyright\>.*?-)\d{4}(.*?\</copyright\>)" = "`${1}$($Latest.ReleaseYear)`${2}"
      "(\<releaseNotes\>).*?(\</releaseNotes\>)"    = "`${1}$($Latest.ReleaseURL)`${2}"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re   = '-windows-amd64\.zip$'
  $urls = $download_page.links | where-object href -match $re | foreach-object href

  $streams = @{}

  $urls | foreach-object {
    $version      = $_ -split '\/v?' | select-object -last 1 -skip 1
    $majorVersion = $version -replace '^(\d+\.\d+).*', "`$1"

    if (!$streams.ContainsKey($majorVersion)) {
      $streams.Add($majorVersion, @{
          Version     = Get-Version $version
          URL64       = $domain + $_
          ReleaseURL  = "$domain/etcd-io/etcd/releases/tag/v${version}"
          ReleaseYear = (Get-Date).ToString('yyyy')
        }
      )
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
