function Get-32BitInstalledOn64BitSystem() {
  param(
    [Parameter(Mandatory = $true)]
    [string]$product
  )
  $systemIs64bit = Get-ProcessorBits 64

  if (-Not $systemIs64bit) {
    return $false
  }

  $registryPaths = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
    'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
  )

  $installedVersions = Get-ChildItem $registryPaths | Get-ItemProperty |Where-Object { $_.DisplayName -match "$product" }

  if (
    $installedVersions.InstallLocation -match 'x86' `
    -and $systemIs64bit
  ) {
    return $true
  }
}