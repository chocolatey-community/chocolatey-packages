[array]$key = Get-UninstallRegistryKey -SoftwareName 'Brave*'
$installedVersion = $key.Version[3..($key.Version.length - 1)]
$installedVersion = "$installedVersion" -replace '\s',''

if (-not $env:ChocolateyForce) {
  try {
    if ($installedVersion -ge [Version]::Parse($env:ChocolateyPackageVersion))
    {
      $alreadyInstalled = $installedVersion
      return
    }
  } catch {
    # Installed version couldn't be checked, attempt installation
  }
}