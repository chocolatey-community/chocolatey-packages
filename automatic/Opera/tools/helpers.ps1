function Is32BitInstalled {
  if ((Get-ProcessorBits 32) -or ($env:ChocolateyForceX86 -eq $true)) {
    # We return $false here to have choco handle the 32bit processing instead
    return $false
  }
  $regPath = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Opera*"

  return Test-Path $regPath -ea 0
}

function IsVersionAlreadyInstalled {
  param($version)

  if ($env:ChocolateyForce ) { return $false }

  [array]$keys = Get-UninstallRegistryKey -SoftwareName "Opera*" -wa 0 | ? { $_.DisplayVersion -and $_.DisplayVersion -eq $version }
  if (!$keys) { return $false }

  if (Is32BitInstalled -or ($env:ChocolateyForceX86 -eq $true)) { return $keys | ? { $_.PSPath -match 'Wow6432Node' } }
  else { return $keys | ? { $_.PSPath -notmatch 'Wow6432Node' }}
}
