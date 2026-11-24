Import-Module Chocolatey-AU

$releases = 'https://sourceforge.net/projects/sweethome3d/files/SweetHome3D/'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1 }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}
function global:au_GetLatest {
  $releases_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $available_releases = foreach ($link in $releases_page.Links) {
    if ($link.href -match '/SweetHome3D-(?<version>\d+(?:\.\d+)+)/$') {
      [pscustomobject]@{
        Version = [version]$Matches.version
        Href    = $link.href
      }
    }
  }
  $latest_release = $available_releases | Sort-Object Version -Descending | Select-Object -First 1

  if (-not $latest_release) {
    throw "No Sweet Home 3D releases were found at $releases"
  }

  $release_url = "https://sourceforge.net$($latest_release.Href)"
  $release_page = Invoke-WebRequest -Uri $release_url -UseBasicParsing
  $url32 = $release_page.Links |
    Where-Object href -match "/SweetHome3D-$($latest_release.Version)-windows\.exe/download$" |
    Select-Object -First 1 -ExpandProperty href

  if (-not $url32) {
    throw "No Windows installer was found for Sweet Home 3D $($latest_release.Version) at $release_url"
  }

  @{
    URL32    = $url32
    Version  = $latest_release.Version.ToString()
    FileType = 'exe'
  }
}

update -ChecksumFor none
