$ErrorActionPreference = 'Stop';
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'renamemaster'
  fileType      = 'zip'
  url           = 'http://files.snapfiles.com/directdl/rmv320.zip'
  checksum      = '8a25b3e8cdc40e955a18e6a8ca36b578ad034e2e6f5a6eb7dfec1c6c61a1bc66'
  checksumType  = 'sha256'
  unzipLocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

$executable = Join-Path  $toolsDir "RenameMaster.exe"
$startMenu = [Environment]::GetFolderPath("CommonPrograms")
$startMenuLink = Join-Path $startMenu "Rename Master.lnk"
Install-ChocolateyShortcut $startMenuLink $executable

Remove-Item "$toolsDir\setup.exe" -Force -ea 0
