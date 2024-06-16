$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/scribus/files/scribus/1.6.2/scribus-1.6.2-windows.exe/download'
  checksum       = '57065CFAC522F6FA3D08DE070DF8A0BF84BAA8EEC881F4098A31C2A08A9690D6'
  checksumType   = 'sha256'
  file64         = "$toolsPath\scribus-1.6.2-windows-x64.exe"
  softwareName   = 'Scribus*'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

if ((Get-OSArchitectureWidth -compare 32) -or ($env:chocolateyForceX86 -eq $true)) {
  Install-ChocolateyPackage @packageArgs
}
else {
  Install-ChocolateyInstallPackage @packageArgs
}

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }
