import-module au

$releases = 'https://www.hedgewars.org/download.html'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
      "(?i)(^\s*fileType\s*=\s*)('.*')" = "`$1'$($Latest.FileType)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re  = '\.exe$'
    $url = $download_page.links | ? href -match $re | % href
    $Matches = $null
    $verRe = '\>\s*Latest Hedgewars Release ([\d]+\.[\d\.]+)\s*\<'
    $download_page.Content -match $verRe | Out-Null
    if ($Matches) { $version = $Matches[1] }
    @{
        Version = $version
        URL32   = $url
    }
}

update -ChecksumFor 32
