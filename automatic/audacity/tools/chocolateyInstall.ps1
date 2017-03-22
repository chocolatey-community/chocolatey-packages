$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'audacity'
  fileType       = 'exe'
  file           = gi "$toolsDir\*.exe"
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0, 1223)
}
Install-ChocolateyInstallPackage @packageArgs
rm ($toolsDir + '\*.' + $packageArgs.fileType)

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
