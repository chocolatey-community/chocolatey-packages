$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'patch-my-pc'
  file           = "$toolsDir\PatchMyPC.exe"
  url            = 'https://patchmypc.net/freeupdater/PatchMyPC.exe'
  checksum       = 'c09000573d2d4cd86e2eeda9603eefc574740976c7435f730f159a754db755fd'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$executable = Join-Path  $toolsDir "PatchMyPC.exe"
$startMenu = [Environment]::GetFolderPath("CommonPrograms")
$startMenuLink = Join-Path $startMenu "patch-my-pc.lnk"
Install-ChocolateyShortcut $startMenuLink $executable
