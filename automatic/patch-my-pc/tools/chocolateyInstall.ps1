$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Combatibility - This function has not been merged
if (!(Get-Command Install-ChocolateyPinnedItem -errorAction SilentlyContinue)) {
  . "$toolsDir\helpers.ps1"
}

$packageArgs = @{
  packageName    = 'patch-my-pc'
  file           = "$toolsDir\PatchMyPC.exe"
  url            = 'https://patchmypc.net/freeupdater/PatchMyPC.exe'
  checksum       = 'fb5ce5484306effc8781a7e2f679d168ad7aba808bd78e19a2f05ff000720de4'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyPinnedItem $packageArgs.file
