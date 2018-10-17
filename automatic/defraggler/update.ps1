import-module au

$releases = 'http://www.piriform.com/defraggler/download/standard'

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.URL32 -Algorithm $Latest.ChecksumType32
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe$'
  $url = $download_page.links | ? href -match $re | select -First 1 -expand href

  $download_page = Invoke-WebRequest https://www.piriform.com/defraggler/version-history -UseBasicParsing
  $Matches = $null
  $download_page.Content -match "\<h6\>v((?:[\d]\.)[\d\.]+)"
  $version = $Matches[1]

  @{ URL32 = $url; Version = $version ; ChecksumType32 = 'sha256' }
}

update -ChecksumFor none
