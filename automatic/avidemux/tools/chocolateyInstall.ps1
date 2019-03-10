$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$silentArgs = @('/S')

$packageArgs = @{
  packageName    = 'avidemux'
  fileType       = 'exe'
  file           = "$toolsDir\avidemux_2.7.2_win3.exe"
  file64         = "$toolsDir\Avidemux_2.7.2%20VC%2B%2B%2064bits%20.exe"
  silentArgs     = $silentArgs
  validExitCodes = @(0, 1223)
}
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
