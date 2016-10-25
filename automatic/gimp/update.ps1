import-module au

$releases = 'https://www.gimp.org/downloads/'

function global:au_SearchReplace {
   @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url(64bit)?\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum(64)?\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType(64)?\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
      "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.RemoteVersion)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  $re    = '\.exe$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

  if ($url.StartsWith("//")) {
    $url = "https:" + $url;
  }

  $version  = $url -split '[-]|.exe' | select -Last 1 -Skip 2

  return @{ URL32 = $url; Version = $version ; RemoteVersion = $version }
}

update -ChecksumFor 32
