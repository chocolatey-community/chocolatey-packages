$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = 'exe'
  file           = Get-Item $toolsPath\*-i386.exe
  file64         = Get-Item $toolsPath\*_64.exe
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Pencil*'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" "" }}
