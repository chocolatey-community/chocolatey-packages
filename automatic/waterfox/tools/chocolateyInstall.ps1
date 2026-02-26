$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

if ((Get-OSArchitectureWidth -Compare 32) -or $env:chocolateyForceX86 -eq $true) {
  throw "Waterfox do not support 32bit (x86) installation."
}

$packageArgs = @{
  packageName   = 'Waterfox'
  fileType      = 'exe'
  softwareName  = 'Waterfox*'
  file          = "$toolsDir\Waterfox Setup 6.6.9_x64.exe"
  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $packageArgs.file -Force -ErrorAction SilentlyContinue
