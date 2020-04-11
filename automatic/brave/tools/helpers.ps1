function Get-InstalledVersion() {
  [array]$key = Get-UninstallRegistryKey -SoftwareName 'Brave*'
  if ($key.Length -ge 1) {
    $installedVersion = $key.Version[3..($key.Version.length - 1)]
    $installedVersion = "$installedVersion" -replace '\s', ''

    if ($installedVersion -and (-not $env:ChocolateyForce)) {
      return [version]$installedVersion
    }
  }

  return $null
}
