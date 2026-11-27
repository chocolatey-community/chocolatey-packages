Import-Module Chocolatey-AU

$releases = 'https://api.github.com/repos/ots-downloader/onthespot/releases'

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
    }
  }
}

function global:au_GetLatest {
  # The 2.x releases are web application images without a Windows build, so only
  # the releases that still ship a Windows executable are considered.
  # Invoke-RestMethod returns the release list as a single object, so it has to
  # be stored in a variable before it is filtered.
  $allReleases = Invoke-RestMethod -UseBasicParsing -Uri $releases
  $release = $allReleases | Where-Object {
    -not $_.draft -and -not $_.prerelease -and $_.assets.name -match '^OnTheSpot-x86_64\.exe'
  } | Select-Object -First 1

  return @{
    Version = $release.tag_name -replace '^v', ''
  }
}

update -ChecksumFor none
