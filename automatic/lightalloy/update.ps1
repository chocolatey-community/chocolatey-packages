import-module au
import-module $PSScriptRoot\..\..\scripts\au_extensions.psm1

$releases = 'http://light-alloy.verona.im/download/'

function global:au_SearchReplace {
  @{
      ".\legal\VERIFICATION.txt" = @{
        "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
        "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
      }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }
function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 1 }

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url = $download_page.Links | ? href -match "LA_Setup_v[0-9\.]+\.exe$" | % href | select -First 1
  $version = $url -split '_v|\.exe' | select -Last 1 -Skip 1

  @{
    Version = $version
    Url32   = $url
  }
}

update -ChecksumFor none
