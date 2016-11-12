import-module au

$domain   = 'https://github.com'
$releases = "$domain/aptana/studio3/releases/latest"

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

  $re    = '\.exe$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

  $version  = $url -split '/' | select -Last 1 -Skip 1
  $version = $version.TrimStart('v');

  if ($url.StartsWith('/')) {
    $url = $domain + $url
  }

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor 32
