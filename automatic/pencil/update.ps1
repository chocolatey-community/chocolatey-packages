[CmdletBinding()]
param([switch] $Force)

Import-Module Chocolatey-AU

$releases = "http://pencil.evolus.vn/Downloads.html"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseURL)>"
      "(?i)(^\s*software.*)\<.*\>"        = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum\:).*"            = "`${1} $($Latest.Checksum32)"
    }

    ".\tools\chocolateyInstall.ps1" = @{
      '(^[$]version\s*=\s*)(".*")'               = "`${1}""$($Latest.Version)"""
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseURL)`${2}"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $domain = $releases -split '(?<=//.+)/' | Select-Object -First 1

  $re = '\.exe$'
  $url = $download_page.links | Where-Object href -match $re | ForEach-Object { $domain + $_.href }

  $version = $url -split '/' | Select-Object -last 1 -Skip 1
  $version = $version.Substring(1) -replace '\.\w+$'

  @{
    Version     = $version
    Url32       = $url
    ReleaseURL  = $download_page.links.href | Where-Object { $_ -like "*github*/release/*"} | Select-Object -first 1
  }
}

update -ChecksumFor none -Force:$Force
