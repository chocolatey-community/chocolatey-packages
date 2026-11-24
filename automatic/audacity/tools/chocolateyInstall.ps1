$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'audacity'
  fileType       = 'msi'
  file           = "$toolsDir\audacity-win-4.0.2-x86_64.msi"
  file64         = "$toolsDir\audacity-win-4.0.2-x86_64.msi"
  silentArgs     = '/qn /norestart'
  validExitCodes = @(0, 1223, 3010)
}

# For MSI installers, use Install-ChocolateyInstallPackage
# For version 4.0+, 32-bit is not supported, both file and file64 point to x86_64 (64-bit Intel/AMD)
Install-ChocolateyInstallPackage @packageArgs

# Clean up downloaded installers
Get-ChildItem "$toolsDir\*.$($packageArgs.fileType)" | ForEach-Object {
  Remove-Item $_ -ea 0
  if (Test-Path $_) {
    Set-Content "$_.ignore"
  }
}

$packageName = $packageArgs.packageName

# Audacity 4.0+ uses MSI and installs to a predictable location
# For version 4.0+: C:\Program Files\Audacity 4\bin\Audacity4.exe
# For version 3.x: C:\Program Files\Audacity\audacity.exe
# We check for both to maintain compatibility

$possiblePaths = @(
  "${env:ProgramFiles}\Audacity 4\bin\Audacity4.exe",  # v4.0+ MSI
  "${env:ProgramFiles}\Audacity\audacity.exe",         # v3.x EXE
  "${env:ProgramFiles(x86)}\Audacity\audacity.exe"     # v3.x 32-bit
)

$exePath = $possiblePaths | Where-Object { Test-Path $_ } | Select-Object -First 1

if ($exePath) {
  $installDir = Split-Path -Parent (Split-Path -Parent $exePath)
  Write-Host "$packageName installed to '$installDir'"
  Register-Application $exePath
  Write-Host "$packageName registered: $exePath"
}
else {
  Write-Warning "Could not locate Audacity executable for shim creation. Application may still work via Start Menu."
}
