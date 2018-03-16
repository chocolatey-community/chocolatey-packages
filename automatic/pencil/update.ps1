[CmdletBinding()]
param([switch] $Force)

Import-Module AU

$domain   = 'https://github.com'
$releases = "$domain/evolus/pencil/releases/latest"

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix -FileNameBase "pencil"

  # Don't create shim for installer
  New-Item "tools\pencil.exe.ignore" -type file -force | Out-Null
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseURL)>"
      "(?i)(^\s*software.*)\<.*\>"        = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum\:).*"            = "`${1} $($Latest.Checksum32)"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseURL)`${2}"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.zip$'
  $url = $download_page.links | ? href -match $re | % href | select -First 1

  $version = ( Split-Path $url -Leaf).Substring(1).Replace(".zip", "")

  return @{
    Version     = $version
    URL32       = "http://pencil.evolus.vn/dl/V${version}/Pencil-Setup-${version}.exe"
    ReleaseURL  = "$domain/evolus/pencil/releases/tag/v${version}"
  }
}

update -ChecksumFor none -Force:$Force
