$ErrorActionPreference = 'Stop';
$toolsDir = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsDir\helpers.ps1"

$packageArgs = @{
  packageName   = 'renamemaster'
  fileType      = 'zip'
  url           = 'http://files.snapfiles.com/directdl/rmv315.zip'
  checksum      = 'dcc26158f01ad204e7c749ca11b92baf24da2b8a3efed87c0146af3c6f2c7af7'
  checksumType  = 'sha256'
  unzipLocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyPinnedItem "$toolsDir\RenameMaster.exe"

Install-ChocolateyExplorerMenuItem 'openRenameMaster' 'Rename Master...' "$toolsDir\RenameMaster.exe"

Remove-Item "$toolsDir\setup.exe" -Force -ea 0
