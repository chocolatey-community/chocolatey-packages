[CmdletBinding()]
param([switch] $Force)

Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*64\-bit software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"      = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum(64)?\:).*"        = "`${1} $($Latest.Checksum64)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease derailed k9s

  $checksumAsset = $LatestRelease.assets | Where-Object { $_.name -eq 'checksums.sha256' } | Select-Object -ExpandProperty browser_download_url
  $checksum_page = Invoke-WebRequest -Uri $checksumAsset -UseBasicParsing
  $checksum64 = [regex]::Match($checksum_page, "([a-f\d]+)\s*$([regex]::Escape($filename64))").Groups[1].Value

  return @{
    Version        = $LatestRelease.tag_name.TrimStart("v")
    URL64          = $LatestRelease.assets | Where-Object { $_.name -eq 'k9s_Windows_amd64.zip' } | Select-Object -ExpandProperty browser_download_url
    ReleaseNotes   = "https://github.com/derailed/k9s/blob/$($LatestRelease.tag_name)/change_logs/release_$($LatestRelease.tag_name).md"
    ReleaseURL     = $LatestRelease.html_url
    Checksum64     = $checksum64
    ChecksumType64 = "sha256"
  }
}

update -ChecksumFor none -Force:$Force
