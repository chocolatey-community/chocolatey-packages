import-module au

$releases = 'https://www.mendeley.com/release-notes/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

	$url = $download_page.Content -match 'Release Notes for Mendeley Desktop v([1-9\.]+)'
	$version = $matches[1]
	$url = "http://desktop-download.mendeley.com/download/Mendeley-Desktop-${version}-win32.exe"

  @{
    Version = $version
    URL32   = $url
  }
}

update -ChecksumFor 32
