$ErrorActionPreference = 'Stop';
$toolsDir = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsDir\helpers.ps1"

$packageArgs = @{
  packageName   = 'renamemaster'
  fileType      = 'zip'
  url           = ''
  checksum      = ''
  checksumType  = 'sha256'
  unzipLocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyPinnedItem "$toolsDir\RenameMaster.exe"

Install-ChocolateyExplorerMenuItem 'openRenameMaster' 'Rename Master...' "$toolsDir\RenameMaster.exe"

Remove-Item "$toolsDir\setup.exe" -Force -ea 0
