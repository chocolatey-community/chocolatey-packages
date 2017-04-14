$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$installerFile = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') { gi "$toolsDir\*x64*.exe" } else { gi "$toolsDir\*x86*.exe" }

$silentArgs = @('/S')

$packageArgs = @{
  packageName    = 'everything'
  fileType       = 'exe'
  file           = $installerFile
  silentArgs     = $silentArgs
  validExitCodes = @(0, 1223)
}
Install-ChocolateyInstallPackage @packageArgs
rm $toolsDir\*Setup.exe

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation) { Write-Warning "Can't find $PackageName install location"; exit }

Write-Host "$packageName installed to '$installLocation'"
Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"

Write-Host "Starting $packageName"
Start-Process "$installLocation\Everything.exe" -ArgumentList "-startup"
