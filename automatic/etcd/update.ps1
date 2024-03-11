[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module Chocolatey-AU

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseURL)>"
      "(?i)(^\s*software.*)\<.*\>"        = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum\:).*"            = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -data @{
    'copyright'    = "(c) 2013-$($Latest.ReleaseYear) etcd Authors"
    'releaseNotes' = "$($Latest.ReleaseNotes)"
  }
}

function global:au_GetLatest {
  $releases = Get-AllGitHubReleases 'etcd-io' 'etcd'

  $streams = @{}
  $re = '-windows-amd64\.zip$'

  $releases | foreach-object {
    $version      = $_.tag_name.TrimStart('v')
    $majorVersion = $version -replace '^(\d+\.\d+).*', "`$1"

    if (!$streams.ContainsKey($majorVersion)) {
      $url = $_.assets | Where-Object name -Match $re | Select-Object -ExpandProperty browser_download_url

      $streams.Add($majorVersion, @{
          Version      = Get-Version $version
          URL64        = $url
          ReleaseURL   = $_.html_url
          ReleaseYear  = (Get-Date).ToString('yyyy')
          ReleaseNotes = $_.body
        }
      )
    }
  }

  return @{ Streams = $streams }
}

Update-Package -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
