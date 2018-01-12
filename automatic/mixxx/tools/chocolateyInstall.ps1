$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'mixxx'
  fileType       = 'exe'
  file           = gi $toolsPath\*-win32.exe
  file64         = gi $toolsPath\*-win64.exe
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Mixxx *'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" }}


$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find install location"; return }
Write-Host "Installed to '$installLocation'"
