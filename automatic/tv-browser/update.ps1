import-module au

$releases = 'http://www.tvbrowser.org/index.php?id=tv-browser'

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

  $re    = 'tvbrowser.*\.exe'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

  if ($url.StartsWith("http://sourceforge")) {
    $url = $url -replace '^http','https'
  }

  $version  = $url -split '[_]' | select -Last 1 -Skip 1
  if ($version.Length -eq 1) { $version = "$version.0" }

  return @{ URL32 = $url; Version = $version }
}

update -ChecksumFor 32
