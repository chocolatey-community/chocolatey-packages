$ErrorActionPreference = 'Stop';

$packageName = 'qbittorrent'

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName 'qBittorrent*'

if ($key.Count -eq 1) {
  $key | % {
    $packageArgs = @{
      packageName = $packageName
      fileType    = 'exe'
      silentArgs  = '/S'
      validExitCodes= @(0)
      file          = "$($_.UninstallString)"
    }

    Uninstall-ChocolateyPackage @packageArgs

    $appPathKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\"
    if (Test-Path "$appPathKey\qbittorrent.exe") { Remove-Item "$appPathKey\qbittorrent.exe" -Force }
    if (Test-Path "$appPathKey\qbit.exe") { Remove-Item "$appPathKey\qbit.exe" -Force }
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}
