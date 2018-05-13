$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  url            = 'https://endpoint920510.azureedge.net/s4l/s4l/download/win/Skype-8.21.0.9.exe'
  checksum       = '548261ce4c16771107617e3a567219f830e5c05fc9ecaf461faa73705c461fa3'
  checksumType   = 'sha256'
  silentArgs     = '/qn /norestart STARTSKYPE=FALSE TRANSFORMS=:RemoveDesktopShortcut.mst TRANSFORMS=:RemoveStartup.mst'
  validExitCodes = @(0)
}

# CHeck if the software is already installed
[array]$key = Get-UninstallRegistryKey @packageArgs

if ($key.Count -eq 1) {
  $uninstallArgs = @{
    packageName    = $env:ChocolateyPackageName
    file           = ''
    fileType       = 'MSI'
    silentArgs     = "$($key.PSChildName) /qn /norestart"
    validExitCodes = $packageArgs.validExitCodes
  }
  Uninstall-ChocolateyPackage @uninstallArgs
}
elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "This will most likely cause a 1603 error code when installing skype."
}

Install-ChocolateyPackage @packageArgs
