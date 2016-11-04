import-module au

$domain   = 'https://github.com'
$releases = "$domain/qTox/qTox/releases/latest"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64\s*=\s*)('.*')"        = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  $re    = '\.exe$'
  $urls   = $download_page.links | ? href -match $re | select -First 2 -expand href

  $version  = ($urls[0] -split '/' | select -Last 1 -Skip 1).TrimStart('v')

  @{
    URL32 = $domain + ($urls -notmatch "64" | select -first 1)
    URL64 = $domain + ($urls -match "64" | select -first 1)
    Version = $version
  }
}

update
