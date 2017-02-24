import-module au

$domain   = 'https://bitbucket.org'
$releases = "$domain/hbons/sparkleshare/downloads"

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
  try { $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases } catch { throw 'Downloading releases page failed' }

  $re    = 'sparkleshare.*\.msi$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

  $version  = $url -split '[-]|.msi' | select -Last 1 -Skip 1

  $url = $domain + $url

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor 32
