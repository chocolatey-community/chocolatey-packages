$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  file           = "$toolsDir\BleachBit-4.6.2-setup.exe"
  fileType       = 'exe'
  silentArgs     = '/S /allusers'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem "$toolsDir\*.exe" | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
