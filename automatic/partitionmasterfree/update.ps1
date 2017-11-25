import-module au

$releases = 'http://www.partition-tool.com/easeus-partition-manager/history.htm'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $version = $download_page.Content -match 'EaseUS Partition Master ([0-9\.]+) Free Edition'
  $version = $matches[1]
  $url = "http://download.easeus.com/free/epm.exe"

  @{
    Version = $version
    URL32   = $url
  }
}

update -ChecksumFor 32
