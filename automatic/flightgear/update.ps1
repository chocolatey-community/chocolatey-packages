import-module au

# We can't use https for the url, otherwise powershell throws an error and closes the window.
# Oddly it works when choco auto redirects http to https
$downloads = 'https://sourceforge.net/projects/flightgear/files'
$changelog = 'http://wiki.flightgear.org/Changelog_'
$versions = 'http://www.flightgear.org/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^[$]version\s*=\s*)('.*')"        = "`$1'$($Latest.RemoteVersion)'"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`$1$($Latest.ReleaseNotes)`$2"
    }
  }
}

function global:au_GetLatest {
  $version_page = Invoke-WebRequest -UseBasicParsing -Uri $versions
  $re = "(?i)Current stable release: (?<stable>[0-9\.]+)"
  if($version_page.Content -match $re)
  {
    $version = $Matches.stable
    $short_version =  $version.Substring(0, $version.LastIndexOf("."))
  } else
  {
    throw "Cannot obtain the latest version from FlightGear's homepage, please update the `"update.ps1`" script."
  }

  $url = "$downloads/release-$short_version/FlightGear-$version.exe/download"

  $releaseNotes = "$changelog$short_version"

  @{
    URL32 = $url
    Version = $version
    RemoteVersion = $version
    ReleaseNotes = $releaseNotes
  }
}

update -ChecksumFor none
