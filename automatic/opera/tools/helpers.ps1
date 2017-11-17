function IsVersionAlreadyInstalled {
  param($version)

  if ($env:ChocolateyForce ) { return $false }

  [array]$keys = Get-UninstallRegistryKey -SoftwareName "Opera*" -wa 0 | ? { $_.DisplayVersion -and $_.DisplayVersion -eq $version }
  return $keys.Count -gt 0
}
