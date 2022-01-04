Import-Module AU

$releases     = 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/latest'

function global:au_SearchReplace {
  [version]$version = $Latest.RemoteVersion
  $docsUrl = "http://www.ghostscript.com/doc/$($version)/Readme.htm"
  $releaseNotesUrl = "https://ghostscript.com/doc/$($version)/History$($version.Major).htm"
  @{
    ".\Ghostscript.nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).app`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
      "(?i)(^\s*\<docsUrl\>).*(\<\/docsUrl\>)" = "`${1}$docsUrl`${2}"
      "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" ` = "`${1}$releaseNotesUrl`${2}"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  # Linux version uses the correct version as we expect, so we use that
  # version as the base.

  $linuxTarbal = $download_page.Links | ? href -match 'ghostscript-.*.tar.gz' | select -First 1 -ExpandProperty href

  $version = $linuxTarbal -split '-|\.tar' | select -Last 1 -Skip 1

  $re = "gs$($version -replace '\.')w32\.exe$"
  $url32 = $download_page.Links | ? href -match $re | % { [uri]::new($download_page.BaseResponse.ResponseUri, $_.href) } | select -first 1

  $re = "gs$($version -replace '\.')w64\.exe$"
  $url64 = $download_page.links | ? href -match $re | % { [uri]::new($download_page.BaseResponse.ResponseUri, $_.href) } | select -first 1

  if (!$url32 -or !$url64) {
    throw "Either 32bit or 64bit URL is missing, please verify this is correct!"
  }

  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version
    RemoteVersion = $version
    PackageName = 'Ghostscript'
  }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}
