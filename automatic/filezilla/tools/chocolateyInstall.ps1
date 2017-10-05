$ErrorActionPreference = 'Stop'

$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'filezilla'
  fileType       = $fileType
  file           = gi $toolsPath\*_x32.exe
  file64         = gi $toolsPath\*_x64.exe
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
  softwareName   = 'FileZilla Client*'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { Set-Content -Value "" -Path "$_.ignore" }}
