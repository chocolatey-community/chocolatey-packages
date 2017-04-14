
import-module au

$releases = 'https://www.360totalsecurity.com/en/download-free-antivirus/360-total-security/?offline=1'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $HTML = Invoke-WebRequest -UseBasicParsing -Uri $releases
  $url = $HTML.Links | ? href -match "\.exe$" | select -first 1 -expand href
  $version = $url -split '_|(\.exe)' | select -last 1 -skip 2

  $url = 'https:' + $url

  return @{ URL32 = $url; Version = $version }
}
update -ChecksumFor 32
