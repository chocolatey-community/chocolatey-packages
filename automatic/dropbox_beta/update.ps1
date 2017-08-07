
import-module au
 . "$PSScriptRoot\..\dropbox\update_helper.ps1"

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32 = Get-RemoteChecksum -Algorithm $Latest.ChecksumType32 -Url $Latest.URL32
  # Copy the original file from the dropbox folder
  if (!(Test-Path "$PSScriptRoot\tools" -PathType Container)) { New-Item -ItemType Directory "$PSScriptRoot\tools" }
  Copy-Item "$PSScriptRoot\..\dropbox\tools" "$PSScriptRoot" -Force -Recurse
  Copy-Item "$PSScriptRoot\..\dropbox\Readme.md" "$PSScriptRoot" -Force -Recurse
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {

 $build = '-beta';
 $oldversion = ($Latest.nuspecversion -replace($build,''));
 $beta = ( drpbx-compare $oldversion -build ($build -replace('-','')) )
 $url = "https://dl-web.dropbox.com/u/17/Dropbox%20${beta}.exe"

 return @{ PackageName = 'dropbox'; URL32 = $url; Version = ($beta + $build); }

}

update -ChecksumFor none
