Import-Module Chocolatey-AU

$releases = 'https://www.ccleaner.com/speccy/download/standard'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $downloadPage = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe(\?[a-f\d]+)?$'
  $url = $downloadPage.links | Where-Object href -match $re | Select-Object -First 1 -expand href

  $downloadPage = Invoke-WebRequest -Uri 'https://www.ccleaner.com/speccy/version-history' -UseBasicParsing
  $Matches = $null
  $downloadPage.Content -match "v((?:[\d]\.)[\d\.]+)\</span\>"
  $version = $Matches[1]

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor 32
