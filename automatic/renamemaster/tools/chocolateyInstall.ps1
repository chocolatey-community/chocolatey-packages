$ErrorActionPreference = 'Stop';
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'renamemaster'
  fileType      = 'zip'
  url           = 'http://files.snapfiles.com/directdl/rmv317.zip'
  checksum      = 'cc2745aea8296f617399c3f990dfec150d3a903661fa81c13c9bc3c5386f116e'
  checksumType  = 'sha256'
  unzipLocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

$executable = Join-Path  $toolsDir "RenameMaster.exe"
$startMenu = [Environment]::GetFolderPath("CommonPrograms")
$startMenuLink = Join-Path $startMenu "Rename Master.lnk"
Install-ChocolateyShortcut $startMenuLink $executable

Remove-Item "$toolsDir\setup.exe" -Force -ea 0
