$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  url            = 'https://download.skype.com/5d7ac191986ccb485223c4e4e9e3e4ce/SkypeSetupFull.exe'
  checksum       = '1E4CA5D441A00AC691C58E0AA5890C3FEB395D2DC53DBAE82FAEC7C9DF4E52FC'
  checksumType   = 'SHA256'
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
