Import-Module Chocolatey-AU

$releases = 'https://tixati.com/windows'
$download = 'https://download.tixati.com/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
      "(?i)(^[$]fileName\s*=\s*)('.*')"   = "`$1'$($Latest.FileName)'"
    }
  }
}


function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url32 = $download_page.links | Where-Object href -match '\.win32-install$' | ForEach-Object href
  $url64 = $download_page.links | Where-Object href -match '\.win64-install$' | ForEach-Object href

  $url32 -match 'tixati-([0-9]+.[0-9]+)-[0-9]+.win32-install'
  $version = $Matches[1]
  $file32 = $Matches[0]
  $filename = $file32 -replace ('.win32-install', '.install.exe')

  $url64 -match 'tixati-[0-9]+.[0-9]+-[0-9]+.win64-install'
  $file64 = $Matches[0]

  @{
    Version  = $version;
    FileName = $filename;
    URL32    = -join ($download, $file32, '.exe');
    URL64    = -join ($download, $file64, '.exe');
  }
}

update
