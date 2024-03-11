Import-Module Chocolatey-AU

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(download location on\s*)<.*>" = "`${1}<$($Latest.ReleaseNotesUrl)>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\)[^`"]*`"" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -key releaseNotes -value $Latest.ReleaseNotes
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease 'gobby' 'gobby'

  $re = 'gobby\-[0-9\.]+\-x64.exe$'
  $url32 = $LatestRelease.assets | ? name -match $re | select -Last 1 -ExpandProperty browser_download_url

  $version32 = $LatestRelease.tag_name.TrimStart('v')
  @{
    URL32           = $url32
    Version         = $version32
    ReleaseNotes    = $LatestRelease.body
    ReleaseNotesUrl = $LatestRelease.html_url
  }
}

update -ChecksumFor none
