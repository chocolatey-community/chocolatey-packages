import-module au

$releases = 'https://supertuxkart.net/Download'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"         = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64\s*=\s*)('.*')"       = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*fileType\s*=\s*)('.*')"    = "`$1'$($Latest.FileType)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $urls = $download_page.links | ? href -match "\.exe\/download$" | % href
  $version = $urls[0] -split '/' | select -Last 1 -Skip 2

  @{
    URL32    = $urls -match 'win64' | select -first 1
    URL64    = $urls -match 'win32' | select -first 1
    Version  = $version
    FileType = 'exe'
  }
}

update
