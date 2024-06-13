$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = ''
  checksum       = ''
  checksumType   = 'sha256'
  file64         = "$toolsPath\scribus-1.4.8-windows-x64.exe"
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
