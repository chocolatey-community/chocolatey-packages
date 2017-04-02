
import-module au

$URL32 = 'http://int.down.360safe.com/totalsecurity/360TS_Setup.exe'
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
$links = $HTML.Links | where{ ($_.href -match "360TS_Setup" ) } | Select -first 1
$link = $links.href -split ( '\/' )
$name = $link | Select -Last 1
$ver = $name -replace('.exe','')
$version = $ver -split ( '_' )
  return @{ URL32 = $URL32; Version = ( $version | Select -Last 1 ); }
}
update -ChecksumFor 32
