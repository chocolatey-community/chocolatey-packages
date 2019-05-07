$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters
# Checking for Package Parameters
if (!$pp['UnzipLocation']) { $pp['UnzipLocation'] = "${env:ChocolateyPackageFolder}\tools\${env:ChocolateyPackageTitle}" }
if (!$pp['WorkingDirectory']) { $pp['WorkingDirectory'] = $pp.UnzipLocation }
if (!$pp['TargetPath']) { $pp['TargetPath'] = $pp['WorkingDirectory']+"\bin\${env:ChocolateyPackageTitle}.exe" }
if (!$pp['IconLocation']) { $pp['IconLocation'] = $pp['TargetPath'] }
if (!$pp['Arguments']) { $pp['Arguments'] = "" }
if (!$pp['ShortcutFilePath']) { $pp['ShortcutFilePath'] = ( [Environment]::GetFolderPath('Desktop') ) }
if (!$pp['Shortcut']) { $pp['Shortcut'] = $true }
if (!$pp['WindowStyle']) { $pp['WindowStyle'] = 1 }

$packageParams = @{
  ShortcutFilePath = $pp.ShortcutFilePath
  TargetPath = $pp.TargetPath
  WorkingDirectory = $pp.WorkingDirectory
  Arguments = $pp.Arguments
  IconLocation = $pp.IconLocation
  Description = "FreeCAD Development ${env:ChocolateyPackageVersion}"
  WindowStyle = $pp.WindowStyle
}
if ($pp['Taskbar']) { $packageParams.Add('PinToTaskbar', '') }
if ($pp['Admin']) {  $packageParams.Add('RunAsAdmin','') }


$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = ''
  url            = ''
  url64          = ''
  UnzipLocation	 = $pp.UnzipLocation
  softwareName   = 'FreeCAD*'
  checksum       = ''
  checksumType   = 'sha256'
  checksum64     = ''
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
if ( $packageArgs.filetype -eq '7z' ) {
Install-ChocolateyZipPackage @packageArgs
if ( $pp.Shortcut ) { Install-ChocolateyShortcut @packageParams }
} else {
Install-ChocolateyPackage @packageArgs
}
