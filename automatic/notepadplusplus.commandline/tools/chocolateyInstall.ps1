$ErrorActionPreference = 'Stop'

if (Test-Path "$env:TEMP\npp.running") {
  $programRunning = Get-Content -Path "$env:TEMP\npp.running"
  Remove-Item "$env:TEMP\npp.running"
}

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsPath\npp.8.4.5.portable.7z"
  file64      = "$toolsPath\npp.8.4.5.portable.x64.7z"
  destination = $toolsPath
}

Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0

if ($programRunning -and (Test-Path $programRunning)) {
  Write-Host "Running stopped program"
  Start-Process $programRunning
}
