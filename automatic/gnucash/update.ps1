import-module au

$releases = 'https://www.gnucash.org/download.phtml'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = 'gnucash.*setup\.exe$'
  $url   = $download_page.links | ? href -match $re | select -first 1 -expand href

  $version  = $url -split '[-]' | select -Last 1 -Skip 1

  if ($url -match '^http\:.*sourceforge') {
    $url = $url -replace '^http\:','https:'
  }

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor 32
