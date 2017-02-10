$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsPath\helpers.ps1"

$pp  = Get-PackageParameters
$filePath = "$toolsPath\KeyFinderInstaller_x32.exe"
$packageArgs = @{
  packageName    = 'keyfinder'
  fileType       = 'exe'
  file           = $filePath
  softwareName   = 'Magical Jelly Bean KeyFinder'
  silentArgs     = '/SILENT' + (Get-InstallTasks $pp)
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 $filePath,"$filePath.ignore"

$installDirectory = Get-AppInstallLocation $packageArgs.softwareName

if ($installDirectory) {
  Install-BinFile -Name "keyfinder" -Path "$installDirectory\keyfinder.exe" -UseStart
  Register-Application -ExePath "$installDirectory\keyfinder.exe" -Name "keyfinder"
}
