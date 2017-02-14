import-module au

$releases = 'http://www.light-alloy.ru/download/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
      "(?i)(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
      "(?i)(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url = $download_page.Links | ? href -match "LA_Setup_v[0-9\.]+\.exe$" | % href | select -First 1
  $version = $url -split 'v' | select -First 1 -Skip 1
  $version = $version -split '.exe' | select -First 1

  @{
    Version = $version
    Url32   = $url
  }
}

update -NoCheckUrl -ChecksumFor 32
