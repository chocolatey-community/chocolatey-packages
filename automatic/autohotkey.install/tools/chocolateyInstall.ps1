$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters

if (!$pp['DefaultVer']){
  if ((Get-OSArchitectureWidth 64) -and ($env:chocolateyForceX86 -ne 'true')) {$pp['DefaultVer'] = 'x64' }
  else {$pp['DefaultVer'] = 'U32' }
}

$silentArgs = "/S /$($pp['DefaultVer'])"

$packageArgs = @{
  packageName    = 'autohotkey.install'
  fileType       = 'exe'
  file           = Get-Item "$toolsDir\*.exe"
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
