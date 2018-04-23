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

Install-ChocolateyPackage @packageArgs
