Import-Module Chocolatey-AU

$softwareName = 'Tribler'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'"     = "`${1}'$softwareName'"
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease Tribler tribler

  @{
    URL64        = $LatestRelease.assets | Where-Object {$_.name.EndsWith("x64.exe") -and $_.name -notmatch '-debug_'} | Select-Object -ExpandProperty browser_download_url
    Version      = $LatestRelease.tag_name.TrimStart("v")
    ReleaseNotes = $LatestRelease.html_url
  }
}

update -checksumFor 64
