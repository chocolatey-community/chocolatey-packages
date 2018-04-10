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
  checksum       = 'ddbe04a7295d3b9a1d5fdde7b36ec8af46d7c5364d40b0aca0e154d011a9003e'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyPinnedItem $packageArgs.file
