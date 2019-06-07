$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'qtox'
  fileType       = 'exe'
  file           = gi $toolsPath\*_x32.exe
  file64         = gi $toolsPath\*_x64.exe
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'qTox'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" "" }}
