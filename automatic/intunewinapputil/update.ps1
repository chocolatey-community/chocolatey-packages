Import-Module Chocolatey-AU

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease microsoft Microsoft-Win32-Content-Prep-Tool

  @{
    Version = $LatestRelease.tag_name.TrimStart("v")
    Url32   = "https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/archive/refs/tags/$($LatestRelease.tag_name).zip"
  }
}

function global:au_SearchReplace {
  @{
    "./tools/chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*)"           = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

update -ChecksumFor 32
