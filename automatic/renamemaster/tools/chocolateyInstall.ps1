$ErrorActionPreference = 'Stop';
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'renamemaster'
  fileType      = 'zip'
  url           = 'http://files.snapfiles.com/directdl/rmv319.zip'
  checksum      = 'efcf1c7a7fa0bba50546dbdbbf7d89216b70bbfbc58aa5a2cf50c193f545de6d'
  checksumType  = 'sha256'
  unzipLocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

$executable = Join-Path  $toolsDir "RenameMaster.exe"
$startMenu = [Environment]::GetFolderPath("CommonPrograms")
$startMenuLink = Join-Path $startMenu "Rename Master.lnk"
Install-ChocolateyShortcut $startMenuLink $executable

Remove-Item "$toolsDir\setup.exe" -Force -ea 0
