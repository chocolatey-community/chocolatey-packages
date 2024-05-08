$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  file           = "$toolsPath\cmake-3.29.3-windows-i386.msi"
  file64         = "$toolsPath\cmake-3.29.3-windows-x86_64.msi"
  softwareName   = 'CMake'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem $toolsPath\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

Write-Warning "Note that this package follows the default behaviour of the 'cmake' installer and does not add cmake.exe to the PATH."
Write-Warning "Please see https://gitlab.kitware.com/cmake/cmake/-/issues/21465 for more information."
Write-Warning "If you need cmake.exe on the PATH, please see the package description at https://community.chocolatey.org/packages/cmake.install/#description for options."
