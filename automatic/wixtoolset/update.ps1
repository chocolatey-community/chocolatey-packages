Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

# We are currently tracking version 3. We only track version 3 as it looks like version 4 will be available as a .NET tool,
# and possibly not through its own installer.

$softwareName = 'WiX Toolset*'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*located at\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleasesUrl)>"
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
  $release = Get-GitHubRelease -Owner 'wixtoolset' -Name 'wix3'

  $url = $release.assets | Where-Object browser_download_url -match "\.exe$" | Select-Object -First 1 -ExpandProperty browser_download_url
  $version = $release.name -split 'v' | Select-Object -Last 1

  @{
    URL32         = $url
    Version       = Get-Version $version
    ReleasesUrl   = $release.html_url
    ReleaseNotes = $release.body
  }
}

update -ChecksumFor none
