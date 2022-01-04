﻿$ErrorActionPreference = 'Stop';

$packageName = 'Firefox'

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName 'Mozilla Firefox*' | Where-Object { $_.DisplayName -notmatch "ESR" }

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    $packageArgs = @{
      packageName = $packageName
      fileType    = 'exe'
      silentArgs  = '-ms'
      validExitCodes= @(0)
      file          = "$($_.UninstallString.Trim('"'))"
    }

    Uninstall-ChocolateyPackage @packageArgs

    Write-Warning "Auto Uninstaller may detect Mozilla Maintenance Service."
    Write-Warning "This should not be uninstalled if any other Mozilla product is installed."
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object {Write-Warning "- $($_.DisplayName)"}
}
