import-module au

# We can't use https for the url, otherwise powershell throws an error and closes the window.
# Oddly it works when choco auto redirects http to https
$releases = 'http://ftp.igh.cnrs.fr/pub/flightgear/ftp/Windows/'
$changelogs = 'http://www.flightgear.org/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$(Get-RemoteChecksum -Url $Latest.URL32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'sha256'"
      "(?i)(^[$]version\s*=\s*)('.*')"        = "`$1'$($Latest.RemoteVersion)'"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`$1$($Latest.ReleaseNotes)`$2"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = '^FlightGear.*\.exe$'
  $fileName   = $download_page.links | ? href -match $re | select -Last 1 -expand href
  $url = if ($fileName) { $releases + $fileName }

  $version  = $url -split '[-]|.exe' | select -Last 1 -Skip 1

  $changelog_page = Invoke-WebRequest -UseBasicParsing $changelogs
  $releaseNotes = $changelog_page.links | ? href -match 'Changelog_[0-9\.]+$' | select -first 1 -expand href

  @{
    URL32 = $url
    Version = $version
    RemoteVersion = $version
    ReleaseNotes = $releaseNotes
  }
}

update -ChecksumFor none
