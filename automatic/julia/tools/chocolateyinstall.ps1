﻿$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  file          = "$toolsDir\julia-1.7.1-win32.exe"
  file64        = "$toolsDir\julia-1.7.1-win64.exe"

  softwareName  = 'Julia*'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}
$packageVersion = "1.7.1"

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer as there is no more need for it
Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

# Find the executable of current installed version
[array]$keysCurrentVersion = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName'] | Where-Object {
  ($_.DisplayName -split "\s+" | Select-Object -last 1) -eq $packageVersion
}

if ($keysCurrentVersion.Count -eq 0)  { Write-Warning "Can't find Julia install location"; return }
$executableLocation = $($keysCurrentVersion | Select-Object -First 1).DisplayIcon
Write-Host "Julia installed to '$executableLocation'"

Install-BinFile 'julia' $executableLocation
