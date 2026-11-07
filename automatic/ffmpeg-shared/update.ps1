Import-Module Chocolatey-AU

$releases = 'https://www.gyan.dev/ffmpeg/builds'

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
  $content = (Invoke-WebRequest -Uri "$releases/release-version" -UseBasicParsing).Content
  if ($content -is [byte[]]) { $content = [System.Text.Encoding]::UTF8.GetString($content) }
  $version = $content.Trim()
  if ($version -notmatch '^\d+\.\d+(\.\d+)?$') { throw "Unrecognized version from gyan.dev release-version: '$version'" }

  # Gyan Doshi's GitHub mirror keeps a versioned archive for every release, while gyan.dev only serves
  # the newest one and answers 503 under load. gyan.dev announces a version a little before its mirror.
  $url64 = "https://github.com/GyanD/codexffmpeg/releases/download/$version/ffmpeg-$version-full_build-shared.7z"
  try {
    Invoke-WebRequest -Uri $url64 -Method Head -UseBasicParsing | Out-Null
  }
  catch {
    Write-Warning "Release $version of the shared build is not on GyanD/codexffmpeg yet: $($_.Exception.Message)"
    return 'ignore'
  }

  @{
    URL64   = $url64
    Version = $version
  }
}

update -ChecksumFor none -NoReadme
