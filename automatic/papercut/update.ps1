Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
  Get-RemoteFiles -NoSuffix -Purge
}

function global:au_SearchReplace {
  @{
    '.\tools\chocolateyInstall.ps1' = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }
    '.\legal\VERIFICATION.txt' = @{
      '(?i)(Go to).*<.*>'   = "`${1} <$($Latest.ReleasePage)>"
      '(?i)(\s+32bit Installer:).*'     = "`${1} $($Latest.URL32)"
      '(?i)(\s+64bit Installer:).*'     = "`${1} $($Latest.URL64)"
      '(?i)(\s+32bit[^:]+checksum:).*' = "`${1} $($Latest.Checksum32)"
      '(?i)(\s+64bit[^:]+checksum:).*' = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -key 'releaseNotes' -value $Latest.ReleasePage
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease ChangemakerStudios 'Papercut-SMTP'

  @{
    URL32 = $LatestRelease.assets | Where-Object { $_.name -match "x86.*\.exe$" } | Select-Object -ExpandProperty browser_download_url
    URL64 = $LatestRelease.assets | Where-Object { $_.name -match "x64.*\.exe$" } | Select-Object -ExpandProperty browser_download_url
    Version = $LatestRelease.tag_name
    ReleasePage = $LatestRelease.html_url
  }
}

update -ChecksumFor none
