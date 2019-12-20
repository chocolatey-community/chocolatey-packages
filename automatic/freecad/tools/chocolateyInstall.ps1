$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Checking for Package Parameters
$pp = Get-PackageParameters
if (!$pp.UnzipLocation) { $pp.UnzipLocation = "$toolsDir" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.18.4/FreeCAD-0.18.4.980bf90-WIN-x32-installer.exe'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.18.4/FreeCAD-0.18.4.980bf90-WIN-x64-installer.exe'
  UnzipLocation	 = $pp.UnzipLocation
  softwareName   = 'FreeCAD*'
  checksum       = 'a3c00e00e5321d9786c56d58c501f8a8e43ba9d25f7147cd8b9c869d744be514'
  checksumType   = 'sha256'
  checksum64     = 'd70930110929117c3a198d3c815a9169e383ab88f650431a1a1ece7705d2ef1b'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

$fileName = @{$true=($packageArgs.url);$false=($packageArgs.url64)}[ ((Get-OSBitness) -eq 32) ]
$filename = $fileName -split('/'); $filename = ( $filename[-1] ); $filename = ( $filename -replace( "\.$($packageArgs.fileType)", '' ) )

# Checking for Package Parameters
if (!$pp.WorkingDirectory) { $pp.WorkingDirectory = $pp.UnzipLocation+"\$filename" }
if (!$pp.TargetPath) { $pp.TargetPath = $pp.WorkingDirectory+"\bin\${env:ChocolateyPackageTitle}.exe" }
if (!$pp.IconLocation) { $pp.IconLocation = $pp.TargetPath }
if (!$pp.Arguments) { $pp.Arguments = "" }
if (!$pp.ShortcutFilePath) { $pp.ShortcutFilePath = ( [Environment]::GetFolderPath('Desktop') )+"\${env:ChocolateyPackageTitle}.lnk" }
if (!$pp.Shortcut) { $pp.Shortcut = $true }
if (!$pp.WindowStyle) { $pp.WindowStyle = 1 }

$packageParams = @{
  ShortcutFilePath = $pp.ShortcutFilePath
  TargetPath = $pp.TargetPath
  WorkingDirectory = $pp.WorkingDirectory
  Arguments = $pp.Arguments
  IconLocation = $pp.IconLocation
  Description = "FreeCAD Development ${env:ChocolateyPackageVersion}"
  WindowStyle = $pp.WindowStyle
}

if ($pp.Taskbar) { $packageParams.PinToTaskbar = $true }
if ($pp.Admin) { $packageParams.RunAsAdmin = $true }

if ( $packageArgs.filetype -eq '7z' ) {
Install-ChocolateyZipPackage @packageArgs
$files = get-childitem $pp.WorkingDirectory -Exclude $packageArgs.softwareName -include *.exe -recurse
foreach ($file in $files) {
  #generate an ignore file
  New-Item "$file.ignore" -type file -force | Out-Null
}
if ( $pp.Shortcut ) { Install-ChocolateyShortcut @packageParams }
} else {
Install-ChocolateyPackage @packageArgs
}

# Exporting Package Parameters to json file in toolsdir
$packageParams | ConvertTo-Json | Out-File  ( "$toolsDir\pp.json" )
