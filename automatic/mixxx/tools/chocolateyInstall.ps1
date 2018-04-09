$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'mixxx'
  fileType       = 'exe'
  file           = Get-Item $toolsPath\*-win32.exe
  file64         = Get-Item $toolsPath\*-win64.exe
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Mixxx *'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" }}


$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find install location"; return }
Write-Host "Installed to '$installLocation'"
