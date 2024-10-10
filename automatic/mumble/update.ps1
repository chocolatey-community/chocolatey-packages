Import-Module Chocolatey-AU

$releases = 'https://github.com/mumble-voip/mumble/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleasesUrl)>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_AfterUpdate {
  Update-Metadata -key "releaseNotes" -value $Latest.ReleaseNotes
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease mumble-voip mumble
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url32 = $LatestRelease.assets | Where-Object {$_.name.StartsWith("mumble_client")} | Where-Object {$_.name.EndsWith(".msi")} | Select-Object -ExpandProperty browser_download_url
  $releaseNotes = $download_page.Links | Where-Object href -match "www.mumble.info\/blog" | Select-Object -first 1 -expand href
  if (!$releaseNotes) {
    $releaseNotes = "$LatestRelease.body"
  }
  @{
    URL32        = $url32
    Version      = $LatestRelease.tag_name.TrimStart("v")  # Tags have a "v" prefix
    ReleasesUrl  = $LatestRelease.html_url
    ReleaseNotes = $releaseNotes
  }
}

update -ChecksumFor none
