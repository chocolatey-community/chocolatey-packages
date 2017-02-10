$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$installerFile = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') { gi "$toolsDir\*win64.exe" } else { gi "$toolsDir\*win32.exe" }

$silentArgs = @('/S')

$packageArgs = @{
  packageName    = 'avidemux'
  fileType       = 'exe'
  file           = $installerFile
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
