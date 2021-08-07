Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://github.com/transifex/transifex-client/releases'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix -FileNameBase tx
  if (!(Test-Path "$PSScriptRoot\tools\x64")) {
    mkdir "$PSScriptRoot\tools\x64"
  }

  Move-Item "$PSScriptRoot\tools\$($Latest.FileName64)" "$PSScriptRoot\tools\x64\$($Latest.FileName64)"
}

function global:au_SearchReplace {
  @{
    '.\legal\VERIFICATION.txt'        = @{
      '(?i)(^\s*location on\:?\s*)\<.*\>' = "`${1}<$($Latest.ReleaseUrl)>"
      '(?i)(\s*64\-Bit Software.*)\<.*\>' = "`${1}<$($Latest.URL64)>"
      '(?i)(^\s*checksum\s*type\:).*'     = "`${1} $($Latest.ChecksumType64)"
      '(?i)(^\s*checksum64\:).*'          = "`${1} $($Latest.Checksum64)"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      '(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)' = "`${1}$($Latest.ReleaseUrl)`${2}"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'tx\.py37.*\.exe$'
  $urls = $download_page.Links | Where-Object href -Match $re | Select-Object -First 2 -expand href | ForEach-Object { 'https://github.com' + $_ }

  $verRe = '\/'
  $version = $urls[0] -split "$verRe" | Select-Object -Last 1 -Skip 1
  $url64 = ($urls | Where-Object { $_ -match $version -and $_ -match '3\d+[-.]x64' } | Select-Object -First 1)

  @{
    URL64      = [uri]$url64
    Version    = [version]$version
    ReleaseUrl = "$releases/tag/$version"
  }
}

update -ChecksumFor none
