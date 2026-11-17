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
  try {
    $release = Get-GitHubRelease GyanD codexffmpeg
    if ($release.tag_name -notmatch $versionTag) {
      $release = Get-AllGitHubReleases GyanD codexffmpeg |
        Where-Object { $_.tag_name -match $versionTag } |
        Sort-Object { [version]$_.tag_name } -Descending |
        Select-Object -First 1
    }
  }
  catch {
    # Without a token (pull request builds from forks) the GitHub API is easily rate limited.
    # The 'latest' release page is not, so take the tag from its redirect and check the archive exists.
    Write-Warning "GitHub API call failed ($($_.Exception.Message)); falling back to the latest release page."
    $request = [System.Net.WebRequest]::Create('https://github.com/GyanD/codexffmpeg/releases/latest')
    $request.Method = 'HEAD'
    $response = $request.GetResponse()
    $tag = [uri]::UnescapeDataString(($response.ResponseUri.AbsoluteUri -split '/tag/')[-1])
    $response.Close()
    if ($tag -notmatch $versionTag) {
      Write-Warning "The latest release on GyanD/codexffmpeg is $tag, not a version tag."
      return 'ignore'
    }

    $name = "ffmpeg-$tag-full_build-shared.7z"
    $url = "https://github.com/GyanD/codexffmpeg/releases/download/$tag/$name"
    $assets = @()
    try {
      $check = [System.Net.WebRequest]::Create($url)
      $check.Method = 'HEAD'
      $check.GetResponse().Close()
      $assets = @([pscustomobject]@{ name = $name; browser_download_url = $url })
    }
    catch { }
    $release = [pscustomobject]@{ tag_name = $tag; assets = $assets }
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
