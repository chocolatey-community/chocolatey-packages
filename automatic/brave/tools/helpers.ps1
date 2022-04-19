function Get-InstalledVersion() {
  [array]$key = Get-UninstallRegistryKey -SoftwareName 'Brave*'
  if ($key.Length -ge 1) {
    
    # Exclude the first number in version (9999.1.2.3 => 1.2.3)
    $installedVersion = $key.Version -replace "\d+\.(.*)", '$1'

    if ($installedVersion -and (-not $env:ChocolateyForce)) {
      return [version]$installedVersion
    }
  }

  return $null
}
