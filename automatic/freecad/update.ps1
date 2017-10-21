import-module au

$releases = 'https://www.freecadweb.org/wiki/Download'
$softwareName = 'FreeCAD*'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64\s*=\s*)('.*')"        = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
    ".\freecad.nuspec" = @{
      "\<releaseNotes\>.+" = "<releaseNotes>$($Latest.ReleaseNotes)</releaseNotes>"
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re = 'x86.*\.exe$'
  $url32 = $download_page.Links | ? href -match $re | select -first 1 -expand href

  $re = 'x64.*\.exe$'
  $url64 = $download_page.links | ? href -match $re | select -first 1 -expand href

  $verRe = '\/'
  [version]$version32 = $url32 -split "$verRe" | select -last 1 -skip 1
  [version]$version64 = $url64 -split "$verRe" | select -last 1 -skip 1
  if ($version32 -ne $version64 -and ($version32.Major -ne $version64.Major -or $version32.Minor -ne $version64 -ne $version64.Minor)) {
    throw "32bit version do not match the 64bit version"
  }
  elseif ($version64 -gt $version32) {
    $version32 = $version64
  }

  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version32
    ReleaseNotes = "https://www.freecadweb.org/wiki/Release_notes_$($version32.Major)$($version32.Minor)"
  }
}

update
