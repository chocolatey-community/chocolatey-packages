$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if ((Get-ProcessorBits 32) -or $env:chocolateyForceX86 -eq $true)
  { Write-Error "32-bit is no longer supported. Please install version 1.0.5.20170203" }

$packageArgs = @{
  packageName    = 'djv'
  fileType       = 'exe'
  file           = "$toolsPath\djv-1.1.0-Windows-64.exe"
  softwareName   = 'djv-*'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 $packageArgs.file,"$($packageArgs.file).ignore"
