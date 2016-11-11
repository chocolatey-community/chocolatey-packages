import-module au

$releases = 'http://www.freeciv.org/download.html'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
    }
    "freeciv.nuspec" = @{
      "(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = 'Freeciv.*gtk2.*\.exe$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

  $version  = ($url -split '[-]') -match "^[\d\.]+$" | select -First 1

  $releaseRe = "NEWS\-$version$"
  $releaseNotes = $download_page.links | ? href -match $releaseRe | select -first 1 -expand href

  @{
    URL32 = $url
    Version = $version
    ReleaseNotes = $releaseNotes
  }
}

update -ChecksumFor 32
