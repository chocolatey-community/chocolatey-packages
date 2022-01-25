$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'patch-my-pc'
  file           = "$toolsDir\PatchMyPC.exe"
  url            = 'https://patchmypc.net/freeupdater/PatchMyPC.exe'
  checksum       = '11d5804a57f249e84df5c4e39800b1cc3e32ea7d8eb6491ddda90669f06f63ab'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$executable = Join-Path  $toolsDir "PatchMyPC.exe"
$startMenu = [Environment]::GetFolderPath("CommonPrograms")
$startMenuLink = Join-Path $startMenu "patch-my-pc.lnk"
Install-ChocolateyShortcut $startMenuLink $executable
