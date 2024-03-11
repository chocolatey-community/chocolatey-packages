[CmdletBinding()]
param($IncludeStream, [switch]$Force)
Import-Module Chocolatey-AU

$softwareName = 'LibreCAD'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseUrl)>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -key 'releaseNotes' -value $Latest.ReleaseNotes
}

function global:au_GetLatest {
  $releases = Get-AllGitHubReleases -Owner 'LibreCAD' -Name 'LibreCAD'

  $streams = @{}
  $releases | ForEach-Object {
    if ($_.tag_name -eq 'latest') {
      # This is the continuous build, ie nightly builds so we skip this one
      return
    }

    $version = Get-Version $_.tag_name

    $url = $_.assets | Where-Object browser_download_url -match '\.exe$' | Select-Object -ExpandProperty browser_download_url
    $streamName = $version.ToString(2)

    if (!($streams.ContainsKey($streamName)) -and $url) {
      $streams.Add($streamName, @{
        Version      = $version
        URL32        = $url
        ReleaseNotes = $_.body
        ReleaseUrl   = $_.html_url
      })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
