Import-Module Chocolatey-AU

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*[$]fileName\s*=\s*)('.*')" = "`$1'$($Latest.FileName)'"
    }

    ".\tools\verification.txt"      = @{
      "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
      "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
      "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease AutoHotkey AutoHotkey

  @{
    Version  = Get-Version $LatestRelease.tag_name
    URL32    = $LatestRelease.assets.Where{$_.name.EndsWith('.zip')}.browser_download_url
    FileName = $LatestRelease.assets.Where{$_.name.EndsWith('.zip')}.name
  }
}

update -NoCheckUrl -ChecksumFor none