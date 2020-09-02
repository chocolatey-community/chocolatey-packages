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
  $regex = "\.exe$"
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $urls = $download_page.links | ? href -match $regex | % href
  
  @{
    URL32    = $urls -match 'win32|32bit' | select -first 1
    URL64    = $urls -match 'win64|64bit' | select -first 1
    Version  = Get-Version ($urls -match 'win32|32bit' | select -first 1)
    FileType = 'exe'
  }
}

update
