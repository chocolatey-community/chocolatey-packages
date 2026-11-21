Import-Module Chocolatey-AU

$releases = 'https://pypi.org/pypi/internetarchive/json'

function global:au_SearchReplace {
  @{
    'tools\ChocolateyInstall.ps1' = @{
      "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
    }
  }
}

function global:au_GetLatest {
  $release = Invoke-RestMethod -UseBasicParsing -Uri $releases

  return @{ Version = $release.info.version }
}

update -ChecksumFor none
