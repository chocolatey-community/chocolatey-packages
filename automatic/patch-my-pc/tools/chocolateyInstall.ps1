$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'patch-my-pc'
  file           = "$toolsDir\PatchMyPC.exe"
  url            = 'https://patchmypc.net/freeupdater/PatchMyPC.exe'
  checksum       = 'd5a2ddba0ee5c577268d69bbc129046d48f36c8306c8a57d4f6b2e2ded193202'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$executable = Join-Path  $toolsDir "PatchMyPC.exe"
$startMenu = [Environment]::GetFolderPath("CommonPrograms")
$startMenuLink = Join-Path $startMenu "patch-my-pc.lnk"
Install-ChocolateyShortcut $startMenuLink $executable
