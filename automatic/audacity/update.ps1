Import-Module Chocolatey-AU

function global:au_SearchReplace {
  @{
    '.\tools\chocolateyInstall.ps1' = @{
      "(^\s*packageName\s*=\s*)('.*')"           = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }

    '.\legal\VERIFICATION.txt'      = @{
      '(?i)(Go to).*<.*>'   = "`${1} <$($Latest.ReleasePage)>"
      '(?i)(\s+x32:).*'     = "`${1} $($Latest.URL32)"
      '(?i)(\s+x64:).*'     = "`${1} $($Latest.URL64)"
      '(?i)(checksum32:).*' = "`${1} $($Latest.Checksum32)"
      '(?i)(checksum64:).*' = "`${1} $($Latest.Checksum64)"
    }

  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease audacity audacity

  @{
    URL32   = $LatestRelease.assets | Where-Object {$_.name.EndsWith(".exe") -and $_.name -match "-32bit|-x32"} | Select-Object -ExpandProperty browser_download_url
    URL64   = $LatestRelease.assets | Where-Object {$_.name.EndsWith(".exe") -and $_.name -match "-64bit|-x64"} | Select-Object -ExpandProperty browser_download_url
    Version = $LatestRelease.tag_name.TrimStart('Audacity-')
    ReleasePage = $LatestRelease.html_url
  }
}

update -ChecksumFor none
