Import-Module Chocolatey-AU

$releases = 'https://tixati.com/windows'
$download = 'https://download.tixati.com/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url32 = $download_page.links | Where-Object href -match '\.win32-standalone$' | ForEach-Object href
  $url64 = $download_page.links | Where-Object href -match '\.win64-standalone$' | ForEach-Object href

  $url32 -match 'tixati-([0-9]+.[0-9]+)-[0-9]+.win32-standalone'
  $version = $Matches[1]
  $file32 = $Matches[0]

  $url64 -match 'tixati-[0-9]+.[0-9]+-[0-9]+.win64-standalone'
  $file64 = $Matches[0]

  @{
    Version = $version;
    URL32   = -join ($download, $file32, '.zip');
    URL64   = -join ($download, $file64, '.zip');
  }
}

update
