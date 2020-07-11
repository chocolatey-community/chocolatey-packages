Import-Module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"
. "$PSScriptRoot\update_helper.ps1"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.RemoteVersion)'"
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32 = Get-RemoteChecksum -Algorithm $Latest.ChecksumType32 -Url $Latest.URL32
}
  
function GetDropbox {
param(
  [string]$nu_version,
  [string]$Title,
  [string]$kind
)
  $build = @{$true='-beta';$false=''}[( $kind -match '-' )]
  $oldversion = ($nu_version -replace($build,''));
  $beta = ( drpbx-compare $oldversion -build ($build -replace('-','')) )
  $beta = ( Get-Version $beta ).Version
  # URL no longer valid as of 02/23/2018 $url = "https://dl-web.dropbox.com/u/17/Dropbox%20${beta}.exe"
  $url32 = Get-RedirectedUrl "https://www.dropbox.com/download?build=${beta}&plat=win&type=full"
  $version = -join ($beta , $build)
  @{
    Title         = $Title
    URL32         = $url32
    Version       = $version
    RemoteVersion = $beta
  }
}

$vers = (Get-Version (( Get-RedirectedUrl 'https://www.dropbox.com/download?full=1&plat=win') -replace('%20',''))).Version
$stable = -join ( $vers.Major, "." , $vers.Minor, "." , $vers.Build )

function global:au_GetLatest {
  $streams = [ordered] @{
    stable = GetDropbox -Title "Dropbox" -kind "" -nu_version $stable
    beta = GetDropbox -Title "Dropbox Beta Build" -kind "-beta" -nu_version $stable
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none
