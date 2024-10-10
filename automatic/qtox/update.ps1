Import-Module Chocolatey-AU

$softwareName = 'qTox'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum(64)?\:).*"       = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)(\-SoftwareName\s+)'.*'"       = "`${1}'$softwareName'"
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameBase "setup-$($softwareName)-$($Latest.Version)" }

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease qTox qTox

  $url = $LatestRelease.assets | Where-Object {$_.name.EndsWith(".exe")} | Select-Object -ExpandProperty browser_download_url

  @{
    URL32   = ($url -notmatch '_64-')[0]
    URL64   = ($url -match '_64-')[0]
    Version = $LatestRelease.tag_name.TrimStart("v")
  }
}

update -ChecksumFor none
