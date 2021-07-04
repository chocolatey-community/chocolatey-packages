[CmdletBinding()]
param([switch] $Force)

Import-Module AU

$domain   = 'https://github.com'
$releases = "$domain/minishift/minishift/releases/latest"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
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

  $re  = '-windows-amd64\.zip$'
  $url = $download_page.links | Where-Object href -match $re | ForEach-Object href | Select-Object -First 1

  $version = (Split-Path ( Split-Path $url ) -Leaf).Substring(1)

  return @{
    Version     = $version
    URL64       = $domain + $url
    ReleaseURL  = "$domain/minishift/minishift/releases/tag/v${version}"
    ReleaseYear = (Get-Date).ToString('yyyy')

  }
}

update -ChecksumFor none -Force:$Force
