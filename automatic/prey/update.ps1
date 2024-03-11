[CmdletBinding()]
param($IncludeStream, [switch]$Force)
Import-Module Chocolatey-AU

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*" = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

function global:au_AfterUpdate { Update-Metadata -key 'releaseNotes' -value $Latest.ReleaseNotes }

function global:au_GetLatest {
  $latestRelease = Get-GitHubRelease -Owner "Prey" -Name "Prey-Node-Client"

  $re = 'x86\.msi$'
  $urls32 = $latestRelease.assets.Where{$_.name -match $re}.browser_download_url

  $re = 'x64\.msi$'
  $urls64 = $latestRelease.assets.Where{$_.name -match $re}.browser_download_url

  $streams = @{}
  $urls32 | ForEach-Object {
    $version = Get-Version $latestRelease.tag_name.TrimStart('v')
    $url64 = $urls64 | Where-Object { $_ -match "\/[v\.]{0,2}$version" } | Select-Object -First 1
    if (!($url64)) { throw "URL64 was not found for version $version" }

    if (!($streams.ContainsKey($version.ToString(2)))) {
      $streams.Add($version.ToString(2), @{
        Version = $version.ToString()
        URL32   = $_
        URL64   = $url64
        ReleaseNotes = $latestRelease.html_url
      })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
