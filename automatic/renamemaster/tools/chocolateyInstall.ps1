$ErrorActionPreference = 'Stop';
$toolsDir = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsDir\helpers.ps1"

$packageArgs = @{
  packageName   = 'renamemaster'
  fileType      = 'zip'
  url           = 'http://files.snapfiles.com/directdl/rmv314.zip'
  checksum      = '288def2d13b7509eeb519e78af928bba258761fe4e921a280895f312644ce8c4'
  checksumType  = 'sha256'
  unzipLocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyPinnedItem "$toolsDir\RenameMaster.exe"

Install-ChocolateyExplorerMenuItem 'openRenameMaster' 'Rename Master...' "$toolsDir\RenameMaster.exe"

Remove-Item "$toolsDir\setup.exe" -Force -ea 0
