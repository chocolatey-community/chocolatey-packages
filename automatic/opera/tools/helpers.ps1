function IsVersionAlreadyInstalled {
  param($version)

  if ($env:ChocolateyForce ) { return $false }

  [array]$keys = Get-UninstallRegistryKey -SoftwareName "Opera*" -wa 0 | ? { $_.DisplayVersion -and $_.DisplayVersion -eq $version }
  if (!$keys) { return $false }

  if (Is32BitInstalled -or ($env:ChocolateyForceX86 -eq $true)) { return $keys | ? { $_.PSPath -match 'Wow6432Node' } }
  else { return $keys | ? { $_.PSPath -notmatch 'Wow6432Node' }}
}
