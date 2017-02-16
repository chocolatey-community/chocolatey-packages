import-module au

$releases = 'https://sourceforge.net/projects/glmixer/files/Windows%20Binary/'

function global:au_SearchReplace {
  @{
    "tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64bit\s*=\s*)('.*')"       = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url = $download_page.Links | ? href -match 'indows\.exe' | % href | select -First 1
  $version = $url -replace '.+GLMixer_([0-9\.\-]+).+', '$1'

  @{
    Version      = $version -replace '-', '.'
    URL32        = "https://sourceforge.net/projects/glmixer/files/Windows%20Binary/GLMixer_${version}_Windows.exe"
    URL64        = "https://sourceforge.net/projects/glmixer/files/Windows%20Binary/GLMixer_${version}_Windows.exe"
  }
}

update -ChecksumFor 64
