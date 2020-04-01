$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

if ((Get-OSArchitectureWidth -Compare 32) -or $env:chocolateyForceX86 -eq $true) {
  throw "Waterfox do not support 32bit (x86) installation."
}

$packageArgs = @{
  packageName   = 'waterfox'
  fileType      = 'exe'
  softwareName  = 'Waterfox*'
  file          = "$toolsDir\Waterfox Current 2020.03 Setup_x64.exe"
  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $packageArgs.file -Force -ErrorAction SilentlyContinue
