$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Combatibility - This function has not been merged
if (!(Get-Command Install-ChocolateyPinnedItem -errorAction SilentlyContinue)) {
  Import-Module "$($toolsDir)\Install-ChocolateyPinnedItem.ps1"
}

$packageArgs = @{
  packageName    = 'patch-my-pc'
  file           = "$toolsDir\PatchMyPC.exe"
  url            = 'https://patchmypc.net/freeupdater/PatchMyPC.exe'
  checksum       = '89e508f3bafebbbdbed782ec8afe0bbcb3c63809ae93a9dcec0edd5a3ccd8d10'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyPinnedItem $packageArgs.file
