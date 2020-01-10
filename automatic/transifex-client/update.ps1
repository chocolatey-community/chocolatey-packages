Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://github.com/transifex/transifex-client/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameBase tx }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseUrl)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseUrl)`${2}"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'tx\.py36.*\.exe$'
  $urls = $download_page.Links | ? href -match $re | select -first 2 -expand href | % { 'https://github.com' + $_ }

  $verRe = '\/'
  $version = $urls[0] -split "$verRe" | select -last 1 -skip 1

  @{
    URL64      = [uri]($urls | ? { $_ -match $version -and $_ -match '3\d+\.x64' } | select -First 1)
    Version    = [version]$version
    ReleaseUrl = "$releases/tag/$version"
  }
}

update -ChecksumFor none
