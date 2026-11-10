Import-Module Chocolatey-AU

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*FileFullPath64\s*=\s*`"`[$]toolsPath\\).*`"" = "`${1}$($Latest.FileName64)`""
    }

    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(\s+x64:).*"     = "`${1} $($Latest.URL64)"
      "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_BeforeUpdate {
  Copy-Item -Path "$PSScriptRoot\..\ffmpeg\tools\chocolateyInstall.ps1" -Destination "$PSScriptRoot\tools\chocolateyInstall.ps1" -Force
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  # Gyan Doshi's GitHub mirror keeps a versioned archive for every release, but it also publishes dated
  # git builds (for example 2026-11-09-git-16a345b022). Only a plain version tag counts as a release.
  # That is normally the latest release; if a git build is marked as latest, use the newest version tag instead.
  $versionTag = '^\d+\.\d+(\.\d+)?$'
  $release = Get-GitHubRelease GyanD codexffmpeg
  if ($release.tag_name -notmatch $versionTag) {
    $release = Get-AllGitHubReleases GyanD codexffmpeg |
      Where-Object { $_.tag_name -match $versionTag } |
      Sort-Object { [version]$_.tag_name } -Descending |
      Select-Object -First 1
  }
  if (-not $release) {
    Write-Warning 'No versioned release was found on GyanD/codexffmpeg.'
    return 'ignore'
  }

  $asset = $release.assets | Where-Object { $_.name -eq "ffmpeg-$($release.tag_name)-full_build-shared.7z" }
  if (-not $asset) {
    Write-Warning "Release $($release.tag_name) of GyanD/codexffmpeg has no shared build archive yet."
    return 'ignore'
  }

  @{
    URL64   = $asset.browser_download_url
    Version = $release.tag_name
  }
}

update -ChecksumFor none -NoReadme
