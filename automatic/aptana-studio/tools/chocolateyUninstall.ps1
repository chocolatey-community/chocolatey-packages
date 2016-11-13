$ErrorActionPreference = 'Stop';

$packageName = 'aptana-studio'

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName 'Aptana Studio'

# Aptana adds two keys pointing to the same uninstallation
if (($key.Count -eq 1) -or ($key.Count -eq 2)) {
  $key[0] | % {
    $packageArgs = @{
      packageName   = $packageName
      fileType      = 'MSI'
      silentArgs    = "$($_.PSChildName) /qn /norestart"
      validExitCodes= @(0, 3010, 1605, 1614, 1641)
      file          = ''
    }

    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 2) {
  Write-Warning "$$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}
