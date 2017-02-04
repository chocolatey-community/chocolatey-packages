$ErrorActionPreference = 'Stop';

$packageName = 'keyfinder'

$uninstalled = $false

[array]$key = Get-UninstallRegistryKey -SoftwareName 'Magical Jelly Bean KeyFinder'

if ($key.Count -eq 1) {
  $key | % {
    $packageArgs = @{
      packageName = $packageName
      fileType    = 'exe'
      silentArgs  = '/SILENT'
      file        = "$($_.UninstallString)"
    }

    Uninstall-ChocolateyPackage @packageArgs

    Uninstall-BinFile -Name "keyfinder" -Path "$($_.InstallLocation)\keyfinder.exe"

    $pathsToRemove = @(
      "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\keyfinder.exe"
      "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\keyfinder.exe"
    )

    foreach ($path in $pathsToRemove) {
      if (Test-Path $path) {
        Remove-Item -Force -ea 0 $path
      }
    }
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstall."
  Write-Warning "Please alert the package maintainer the following keys were matched:"
  $key | % { Write-Warning "- $($_.DisplayName)" }
}
