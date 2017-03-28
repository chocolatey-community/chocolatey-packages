import-module au

$releases = 'https://github.com/Gnucash/gnucash/releases/latest'

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
  $download_page = Invoke-WebRequest -Uri $releases

  $re    = '^/.+\.exe$'
  $url   = $download_page.links | ? href -match $re | select -first 1 -expand href

  $version  = $url -split '\/' | select -Last 1 -Skip 1

  if (!($version -match "^[\d\.]+$")) {
    # They change the filename again, lets try the tag name
    $version = ($url -split '\/' | select -last 1 -skip 1)
  }

  @{
    URL32 = 'https://github.com' + $url
    Version = $version
  }
}

update -ChecksumFor 32
