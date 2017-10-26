$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if ((Get-ProcessorBits 32) -or $env:chocolateyForceX86 -eq $true)
  { Write-Error "32-bit is no longer supported. Please install version 1.0.5.20170203" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\djv-1.1.0-Windows-64.exe"
  softwareName   = 'djv-*'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" } }
