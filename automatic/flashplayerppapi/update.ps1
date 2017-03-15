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
      "(^[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /t REG_DWORD /v 1A10 /f /d 0 | out-null
  $HTML = Invoke-WebRequest -Uri $releases
  $try = ($HTML.ParsedHtml.getElementsByTagName('p') | Where{ $_.id -eq 'AUTO_ID_columnleft_p_version' } ).innerText
  $try = $try  -split "\r?\n"
  $try = $try[0] -replace ' ', ' = '
  $try =  ConvertFrom-StringData -StringData $try
  $currentVersion = ( $try.Version )
  $majorVersion = ([version] $currentVersion).Major
  $HTML.close
  reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v 1A10 /f | out-null
  $url32 = "https://download.macromedia.com/pub/flashplayer/pdc/${currentVersion}/install_flash_player_${majorVersion}_ppapi.msi"

  return @{
    URL32 = $url32
    Version = Get-Padded-Version $currentVersion $padVersionUnder
  }
}

update -ChecksumFor 32
