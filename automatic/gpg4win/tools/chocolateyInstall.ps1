$ErrorActionPreference = 'Stop'

Get-Service dirmngr -ea 0 | Stop-Service

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'gpg4win'
  fileType       = $fileType
  file           = Get-Item $toolsPath\*.exe
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Gpg4Win *'
}

$pp = Get-PackageParameters

if ($pp['Config']) {
  Write-Host "Using passed configuration file..."
  $packageArgs["silentArgs"] = "/S /C=$($pp["Config"])"
}

Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { New-Item "$($_.FullName ).ignore" }}
