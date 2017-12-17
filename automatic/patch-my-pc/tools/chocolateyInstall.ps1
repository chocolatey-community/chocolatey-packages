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
  checksum       = 'a3f669d53ed71b3dc600d0f075f8fa57e9e8b4f1da3ab17694489a5c8b209f3a'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyPinnedItem $packageArgs.file
