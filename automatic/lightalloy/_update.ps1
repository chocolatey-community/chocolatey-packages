import-module au

$releases = 'http://light-alloy.verona.im/download/'

function global:au_SearchReplace {
  @{
      ".\legal\VERIFICATION.txt" = @{
        "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
        "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
      }
  }
}

function global:au_BeforeUpdate {
  $fileName = $Latest.Url32 -split '\/' | select -last 1
  $toolsDir = "$PSScriptRoot\tools"
  rm "$toolsDir\*.exe"

  $Latest.FileName32 = $fileName
  Invoke-WebRequest -Uri $Latest.URL32 -WebSession $Latest.WebSession -UseBasicParsing -OutFile "$toolsDir\$fileName"
  $Latest.Checksum32 = Get-FileHash "$toolsDir\$fileName" -Algorithm SHA256 | % Hash
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -SessionVariable websession -UseBasicParsing
  $cookies = $websession.Cookies.GetCookies($releases)
  $download_page = Invoke-WebRequest -Uri "${releases}?attempt=1" -UseBasicParsing -WebSession $websession
  $url = $download_page.Links | ? href -match "LA_Setup_v[0-9\.]+\.exe$" | % href | select -First 1
  $version = $url -split '_v|\.exe' | select -Last 1 -Skip 1

  @{
    Version = $version
    Url32   = $url
    WebSession = $websession
  }
}

update -ChecksumFor none -NoCheckUrl
