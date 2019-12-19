import-module au
 . ".\update_helper.ps1"
 
$PreUrl = 'https://github.com'
$releases = "$PreUrl/FreeCAD/FreeCAD/releases"
$regex = "(\d+\.\d+\.\d+)"
$softwareName = 'FreeCAD*'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*fileType\s*=\s*)('.*')"       = "`$1'$($Latest.fileType)'"
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'"     = "`${1}'$softwareName'"
    }
    ".\freecad.nuspec" = @{
      "\<releaseNotes\>.+" = "<releaseNotes>$($Latest.ReleaseNotes)</releaseNotes>"
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^\s*fileType\s*=\s*)('.*')"       = "`$1'$($Latest.fileType)'"
    }
  }
}

function global:au_GetLatest {
  $streams = [ordered] @{
    stable = Get-FreeCad -Title "FreeCAD" -kind "stable"
    dev = Get-FreeCad -Title "FreeCAD" -kind "dev"
  }
  return @{ Streams = $streams }
}

update

