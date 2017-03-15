
import-module au
. "$PSScriptRoot\..\..\scripts\Get-Padded-Version.ps1"

$releases = "https://get.adobe.com/en/flashplayer/" # URL to for GetLatest
$padVersionUnder = '24.0.1'

function global:au_BeforeUpdate {
  # We need this, otherwise the checksum won't get created
  # Since windows 8 or later is skipped.
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32     = Get-RemoteChecksum $Latest.URL32
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]version\s*=\s*)('.*')"= "`$1'$($Latest.RemoteVersion)'"
      "(^[$]majorVersion\s*=\s*)('.*')"= "`$1'$($Latest.majorVersion)'"
      "(^[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  
  $HTML = Invoke-WebRequest -UseBasicParsing -Uri $releases
  $try = ($HTML.ParsedHtml.getElementsByTagName('p') | Where{ $_.className -eq 'NoBottomMargin' } ).innerText
  $try = $try  -split "\r?\n"
  $try = $try[0] -replace ' ', ' = '
  $try =  ConvertFrom-StringData -StringData $try
  $CurrentVersion = ( $try.Version )
  $majorVersion = ([version] $CurrentVersion).Major
  $HTML.close
  
  $url32 = "https://download.macromedia.com/pub/flashplayer/pdc/${CurrentVersion}/install_flash_player_${majorVersion}_active_x.msi"

  $packageVersion = Get-Padded-Version $CurrentVersion $padVersionUnder

  return @{ URL32 = $url32; Version = $packageVersion; RemoteVersion = $CurrentVersion; majorVersion = $majorVersion; }
}

update -ChecksumFor none
