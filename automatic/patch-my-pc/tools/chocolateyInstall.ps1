$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'patch-my-pc'
  file           = "$toolsDir\PatchMyPC.exe"
  url            = 'https://patchmypc.net/freeupdater/PatchMyPC.exe'
  checksum       = '6f94aab81c7f981d7629046495aec08fbfd064326a51a76119f15e1f76a846f8'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$executable = Join-Path  $toolsDir "PatchMyPC.exe"
$startMenu = [Environment]::GetFolderPath("CommonPrograms")
$startMenuLink = Join-Path $startMenu "patch-my-pc.lnk"
Install-ChocolateyShortcut $startMenuLink $executable
