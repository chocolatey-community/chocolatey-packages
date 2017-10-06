$ErrorActionPreference = 'Stop'

$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'bulk-crap-uninstaller'
  fileType       = 'exe'
  file           = gi $toolsPath\*.exe
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  softwareName   = 'BCUninstaller'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" }}
