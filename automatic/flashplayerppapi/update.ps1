import-module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'http://fpdownload2.macromedia.com/get/flashplayer/update/current/xml/version_en_win_pl.xml'
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
      "(^[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {

  $XML = New-Object  System.Xml.XmlDocument
  $XML.load($releases)
  $currentVersion = $XML.XML.update.version.replace(',', '.')
  $majorVersion = ([version]$currentVersion).Major

  $url32 = "https://download.macromedia.com/pub/flashplayer/pdc/${currentVersion}/install_flash_player_${majorVersion}_ppapi.msi"

  return @{
    URL32 = $url32
    Version = Get-PaddedVersion $currentVersion $padVersionUnder
  }
}


update -ChecksumFor 32