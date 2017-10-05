$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$filePath = "$toolsPath\KeePass-1.34-Setup.exe"
$packageArgs = @{
  packageName    = 'keepass-classic'
  fileType       = 'exe'
  file           = $filePath
  softwareName   = 'KeePass Password Safe 1*'
  silentArgs     = '/VERYSILENT' + (Get-InstallTasks $pp)
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 $filePath,"$filePath.ignore"
