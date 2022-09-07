$ErrorActionPreference = 'Stop'

if (Test-Path "$env:TEMP\npp.running") {
  $programRunning = Get-Content -Path "$env:TEMP\npp.running"
  Remove-Item "$env:TEMP\npp.running"
}

# Temporary code until we have at least one version with the before modify script
$process = Get-Process "Notepad++*" -ea 0

if ($process) {
  $processPath = $process | Where-Object { $_.Path } | Select-Object -First 1 -ExpandProperty Path
  Write-Host "Found Running instance of Notepad++. Stopping processes..."
  $process | Stop-Process
  $programRunning = $processPath
}


$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\npp.8.4.5.Installer.exe"
  file64         = "$toolsPath\npp.8.4.5.Installer.x64.exe"
  softwareName   = 'Notepad\+\+*'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  {  Write-Warning "Can't find $PackageName install location"; return }

Write-Host "$packageName installed to '$installLocation'"
Install-BinFile -Path "$installLocation\notepad++.exe" -Name 'notepad++'

if ($programRunning -and (Test-Path $programRunning)) {
  Write-Host "Running stopped program"
  Start-Process $programRunning
}
