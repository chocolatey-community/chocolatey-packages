$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'patch-my-pc'
  file           = "$toolsDir\PatchMyPC.exe"
  url            = 'https://patchmypc.net/freeupdater/PatchMyPC.exe'
  checksum       = 'a26fe78c498d9cea84970a8b1ad36974c5e0bd578f4f6dd27cca73f975917a97'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$executable = Join-Path  $toolsDir "PatchMyPC.exe"
$startMenu = [Environment]::GetFolderPath("CommonPrograms")
$startMenuLink = Join-Path $startMenu "patch-my-pc.lnk"
Install-ChocolateyShortcut $startMenuLink $executable
