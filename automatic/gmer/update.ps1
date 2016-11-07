import-module au

$releases = 'http://www.gmer.net/'

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

  $re    = 'gmer.*\.zip$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

  $download_page.AllElements | ? innerText -match "^GMER ([0-9\.]+)$" | Out-Null
  $version = [version]::Parse($Matches[1])

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor 32
