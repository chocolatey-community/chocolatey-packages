function Get-InstalledVersion() {
  [array] $keys = Get-UninstallRegistryKey -SoftwareName 'TortoiseGit*'

  if ($keys.Length -ge 1) {
      return [version] ($keys[0].DisplayVersion)
  }

  return $null
}
