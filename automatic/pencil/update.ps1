[CmdletBinding()]
param([switch] $Force)

Import-Module AU

$releases = "http://pencil.evolus.vn/Downloads.html"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseURL)>"
      "(?i)(^\s*software.*)\<.*\>"        = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum32\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum64\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum32\:).*"            = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"            = "`${1} $($Latest.Checksum64)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseURL)`${2}"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $domain = $releases -split '(?<=//.+)/' | select -First 1

  $re = '\.exe$'
  $url = $download_page.links | ? href -match $re | % { $domain + $_.href }

  $version = $url[0] -split '/' | select -last 1 -Skip 1
  $version = $version.Substring(1) -replace '\.\w+$'

  @{
    Version     = $version
    URL32       = $url -match 'i386' | select -first 1
    URL64       = $url -notmatch 'i386' | select -first 1
    ReleaseURL  = $download_page.links.href | ? { $_ -like "*github*/release/*"} | select -first 1
  }
}

update -ChecksumFor none -Force:$Force
