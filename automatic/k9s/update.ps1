[CmdletBinding()]
param([switch] $Force)

Import-Module AU

$domain = 'https://github.com'
$releases = "$domain/derailed/k9s/releases/latest"

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
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
  $LatestRelease = Get-GitHubRelease -Owner "derailed" -Name "k9s"

  $re = '_Windows_x86_64\.tar.gz$'
  $url = $latestrelease.assets.browser_download_url | Where-Object { $_ -match $re } | select -First 1

  $version = (Split-Path ( Split-Path $url ) -Leaf).Substring(1)
  $filename64 = Split-Path $url -Leaf

  $checksumAsset = $latestrelease.assets.browser_download_url | Where-Object { $_ -match "checksums\.txt$" } | select -First 1
  $checksum_page = Invoke-WebRequest -Uri $checksumAsset -UseBasicParsing

  $checksum64 = [regex]::Match($checksum_page, "([a-f\d]+)\s*$([regex]::Escape($filename64))").Groups[1].Value

  return @{
    Version        = $version
    URL64          = "$domain/derailed/k9s/releases/download/v${version}/${filename64}" 
    ReleaseNotes   = "$domain/derailed/k9s/blob/v${version}/change_logs/release_v${version}.md"
    ReleaseURL     = "$domain/derailed/k9s/releases/tag/v${version}"
    Checksum64     = $checksum64
    ChecksumType64 = "sha256"
  }
}

update -ChecksumFor none -Force:$Force
