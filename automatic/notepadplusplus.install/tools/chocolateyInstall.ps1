$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\npp.7.5.3.Installer.exe"
  file64         = "$toolsPath\npp.7.5.3.Installer.x64.exe"
  softwareName   = 'Notepad\+\+*'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  {  Write-Warning "Can't find $PackageName install location"; return }

Write-Host "$packageName installed to '$installLocation'"
Install-BinFile -Path "$installLocation\notepad++.exe" -Name 'notepad++'

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }
