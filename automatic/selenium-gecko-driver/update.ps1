Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleasesUrl)>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}
function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease mozilla geckodriver

  @{
    URL32       = $LatestRelease.assets | Where-Object {$_.name.EndsWith('win32.zip')} | Select-Object -ExpandProperty browser_download_url
    URL64       = $LatestRelease.assets | Where-Object {$_.name.EndsWith('win64.zip')} | Select-Object -ExpandProperty browser_download_url
    Version     = $LatestRelease.tag_name.TrimStart("v")
    ReleasesUrl = $LatestRelease.html_url
  }
}

update -ChecksumFor none
