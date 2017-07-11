import-module au

$releases = 'https://www.bennewitz.com/bluefish/stable/binaries/win32/'

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

  $re    = 'Bluefish-[\d\.]+-setup\.exe$'
  $url   = $download_page.links | ? href -match $re | select -Last 1 -expand href

  $version  = $url -split '[-]' | select -Last 1 -Skip 1

  $url = if ($url) { $releases + $url } else { $url }

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor 32
