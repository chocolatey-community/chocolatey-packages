﻿$ErrorActionPreference = 'Stop'

$packageName         = $env:chocolateyPackageName
$softwareNamePattern = 'Opera*'
$toolsDir            = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

[array] $key = Get-UninstallRegistryKey $softwareNamePattern
if ($key.Count -eq 1) {
  $key | ForEach-Object {
    $packageArgs = @{
      packageName    = $packageName
      silentArgs     = "/uninstall"
      fileType       = 'EXE'
      validExitCodes = @(0)
      file           = $_.UninstallString.replace(' /uninstall', '').trim('"')
    }

    $installLocation = Get-AppInstallLocation -AppNamePattern $softwareNamePattern
    if ($null -ne $installLocation) {
      Remove-Process -PathFilter "$([regex]::Escape($installLocation)).*" | Out-Null
    }

    $pp = Get-PackageParameters
    $ahkArgList = New-Object Collections.Generic.List[string]
    $ahkArgList.Add($(Join-Path -Path $toolsDir -ChildPath 'uninstall.ahk'))
    if ($pp.RemoveUserData) {
      $ahkArgList.Add('/RemoveUserData')
    }

    Start-Process -FilePath 'AutoHotKey.exe' -ArgumentList $ahkArgList
    Uninstall-ChocolateyPackage @packageArgs
  }
}
elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}
