Import-Module Chocolatey-AU

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]fileName\s*=\s*)('.*')"      = "`$1'$($Latest.FileName32)'"
      "(?i)(checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }

    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(x32:).*"              = "`${1} $($Latest.URL32)"
      "(?i)(checksum32:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease composer windows-setup

  @{
    URL32        = $LatestRelease.assets | Where-Object {$_.name.EndsWith(".exe")} | Select-Object -ExpandProperty browser_download_url
    Version      = $LatestRelease.tag_name.TrimStart("v")
    ReleaseNotes = $LatestRelease.html_url
  }
}

update -ChecksumFor none
