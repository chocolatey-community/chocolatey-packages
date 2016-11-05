$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'freecad'
  fileType       = 'exe'
  softwareName   = 'FreeCAD*'

  checksum       = 'e3fb34b712e072268d01a95604cc3841d6a766fa6c9347fd9ab4d2defeb31e5c'
  checksum64     = '25b5ddf0b7a40c401f260aeaf5cfbab992e243ae178b316cc82501fe706f3efb'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.16/FreeCAD.0.16.6704.oc449d7-WIN-x86_installer.exe'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.16/FreeCAD-0.16.6706.f86a4e4-WIN-x64_Installer-1.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
