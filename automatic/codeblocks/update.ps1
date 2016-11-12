import-module au
import-module "$PSScriptRoot/../../extensions/chocolatey-fosshub.extension/extensions/Get-UrlFromFosshub.psm1"
. "$PSScriptRoot/../../extensions/chocolatey-core.extension/extensions/Get-WebContent.ps1"

$releases = 'http://www.codeblocks.org/downloads/26'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]fosshubUrl\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
    }
    ".\codeblocks.nuspec" = @{
      "(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = 'fosshub.*mingw-setup\.exe$'
  $url   = $download_page.links | ? href -match $re | select -first 1 -expand href

  if (!$url.StartsWith("https")) {
    $url = $url -replace "^http","https"
  }

  $version  = $url -split '[-]|mingw' | select -Last 1 -Skip 2

  $changelog = $download_page.links | ? title -match "^changelog$" | select -first 1 -expand href

  return @{
    URL32 = $url;
    Version = $version
    ReleaseNotes = $changelog
  }
}

update -NoCheckUrl -ChecksumFor 32
