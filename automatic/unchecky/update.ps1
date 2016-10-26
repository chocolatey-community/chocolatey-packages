import-module au

$releases = 'https://unchecky.com/changelog'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  $re    = 'v([0-9\.]+)'
  $header = $download_page.ParsedHtml.getElementsByTagName('h4') | ? innerText -match $re | select -First 1 -expand innerText

  $version = [regex]::Match($header, $re).Groups[1]

  $url = 'https://unchecky.com/files/unchecky_setup.exe'

  return @{ URL32 = $url; Version = $version }
}

update -ChecksumFor 32
