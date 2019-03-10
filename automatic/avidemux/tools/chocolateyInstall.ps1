$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$silentArgs = @('/S')

$packageArgs = @{
  packageName    = 'avidemux'
  fileType       = 'exe'
  file           = "$toolsDir\"
  file64         = "$toolsDir\"
  silentArgs     = $silentArgs
  validExitCodes = @(0, 1223)
}
Install-ChocolateyInstallPackage @packageArgs
rm $toolsDir\*.exe

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
