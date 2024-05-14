$ErrorActionPreference = 'Stop';
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'renamemaster'
  fileType      = 'zip'
  url           = 'http://files.snapfiles.com/directdl/rmv318.zip'
  checksum      = 'c4d0d4b9d05a720e13745cdc22fd2ba0439dd3e7a8c6f9fa93c12a9d10f200df'
  checksumType  = 'sha256'
  unzipLocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

$executable = Join-Path  $toolsDir "RenameMaster.exe"
$startMenu = [Environment]::GetFolderPath("CommonPrograms")
$startMenuLink = Join-Path $startMenu "Rename Master.lnk"
Install-ChocolateyShortcut $startMenuLink $executable

Remove-Item "$toolsDir\setup.exe" -Force -ea 0
