Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>"   = "`${1}<$($Latest.ReleaseURL)>"
      "(?i)(^\s*64\-bit software.*)\<.*\>"  = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum64\:).*"            = "`${1} $($Latest.Checksum64)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease int128 kubelogin

  return @{
    Version     = $LatestRelease.tag_name.TrimStart("v")
    URL64       = $LatestRelease.assets | Where-Object {$_.name -eq "kubelogin_windows_amd64.zip"} | Select-Object -ExpandProperty browser_download_url
    ReleaseNotes= $LatestRelease.html_url
    ReleaseURL  = $LatestRelease.html_url
  }
}

update -ChecksumFor none
