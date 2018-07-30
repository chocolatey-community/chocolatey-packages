$ErrorActionPreference = 'Stop';

$packageName = '7zip.install'

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName '7-zip*'

if ($key.Count -eq 1) {
  $key | ForEach-Object {
  $packageArgs = @{
    packageName    = $packageName
    fileType       = 'EXE'
    silentArgs     = '/S'
    validExitCodes = @(0)
    file           = "$($_.UninstallString)"
  }

    Uninstall-ChocolateyPackage @packageArgs
    Uninstall-BinFile -Name "7z.exe" -Path $packageArgs["file"]
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object {Write-Warning "- $($_.DisplayName)"}
}
