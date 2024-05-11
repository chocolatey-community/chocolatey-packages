$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

if ((Get-OSArchitectureWidth 32) -or ($env:chocolateyForceX86 -eq 'true')) {
  throw "$env:ChocolateyPackageName do not provide 32bit installer anymore. Please use version 2.2.4 or lower."
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  file64         = "$toolsPath\mixxx-2.4.1-win64.msi"

  softwareName   = 'Mixxx *'

  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs
