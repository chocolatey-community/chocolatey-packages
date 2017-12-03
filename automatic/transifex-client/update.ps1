Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://github.com/transifex/transifex-client/releases/latest'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameBase tx }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'tx\.py35.*\.exe$'
  $urls = $download_page.Links | ? href -match $re | select -first 2 -expand href | % { 'https://github.com' + $_ }

  $verRe = '\/'
  $version = $urls[0] -split "$verRe" | select -last 1 -skip 1

  @{
    URL64        = [uri]($urls | ? { $_ -match 'x64' })
    Version      = [version]$version
    ReleaseNotes = Get-RedirectedUrl $releases
  }
}

update -ChecksumFor none
