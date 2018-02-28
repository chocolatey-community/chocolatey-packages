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
  checksum       = '2ad0da734d134ec682b038e7ec25edca72ed0d0899828028530619e02d34fa9c'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyPinnedItem $packageArgs.file
