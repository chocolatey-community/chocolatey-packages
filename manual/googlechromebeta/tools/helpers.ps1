﻿function Get-Chrome32bitInstalled {
  $registryPath = 'HKLM:\SOFTWARE\WOW6432Node\Google\Update\ClientState\*'
  # We also return nothing if the user forces 32bit installation
  # as we don't need to make any checks in that case.
  if (!(Test-Path $registryPath) -or $env:ChocolateyForceX86 -eq $true) { return }

  $32bitInstalled = Get-Item $registryPath | ForEach-Object {
    if ((Get-ItemProperty $_.pspath).ap -match 'arch_x86$') { return $true }
  }
  if ($32bitInstalled) {
    return $32bitInstalled
  }

  $installLocation = Get-UninstallRegistryKey 'Google Chrome Beta' | ForEach-Object { $_.InstallSource }
  if ($installLocation) {
    return Test-Path "$installLocation\nacl_irt_x86_32.nexe"
  } else {
    Write-Warning "Unable to find the architecture of the installed Google Chrome Beta application"
  }
}

function Get-ChromeBetaVersion() {
  $root   = 'HKLM:\SOFTWARE\Google\Update\Clients'
  $root64 = 'HKLM:\SOFTWARE\Wow6432Node\Google\Update\Clients'
  foreach ($r in $root,$root64) {
    $gcb = Get-ChildItem $r -ea 0 | Where-Object { (Get-ItemProperty $_.PSPath).name -eq 'Google Chrome Beta' }
    if ($gcb) { return $gcb.GetValue('pv') }
  }
}
