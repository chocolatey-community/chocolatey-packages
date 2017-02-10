$ErrorActionPreference = 'Stop';

$packageName = 'picard'

$uninstalled = $false

[array]$key = Get-UninstallRegistryKey -SoftwareName 'MusicBrainz Picard'

if ($key.Count -eq 1) {
  $key | % {

    $packageArgs = @{
      packageName = $packageName
      fileType    = 'exe'
      silentArgs  = '/S'
      file        = "$($_.UninstallString)"
    }

    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstall."
  Write-Warning "Please alert the package maintainer the following keys were matched:"
  $key | % { Write-Warning "- $($_.DisplayName)" }
}
