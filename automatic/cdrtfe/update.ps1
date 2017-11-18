[CmdletBinding()]
param($IncludeStream, [switch]$Force)
Import-Module AU

$releases = 'https://cdrtfe.sourceforge.io/cdrtfe/download_en.html'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '[\d\.]+\.exe$'
  # We need to ignore the older links with kerberos in the url.
  # These do not work, and is commented out but still picked up
  $urls32 = $download_page.Links | ? { $_.href -match $re -and $_ -notmatch "kerberos" } | select -expand href | % { $_ -replace "^(ht|f)tp\:",'https:' }

  $streams = @{}
  $urls32 | % {
    $verRe = '[-]|\.exe|\.msi|\.zip'
    $version = $_ -split "$verRe" | select -last 1 -skip 1
    # Can't get Get-Version to work in this case
    #$version = Get-Version $version
    $versionTwoPart = $version -replace '^([\d]+\.[\d]+).*$','$1'

    if (!($streams.ContainsKey($versionTwoPart))) {
      $streams.Add($versionTwoPart, @{
        Version = $version
        URL32   = $_
      })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
