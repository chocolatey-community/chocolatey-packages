$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Checking for Package Parameters
$pp = Get-PackageParameters
if (!$pp['UnzipLocation']) { $pp['UnzipLocation'] = "$toolsDir" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = ''
  url            = ''
  url64          = ''
  UnzipLocation	 = $pp.UnzipLocation
  softwareName   = 'FreeCAD*'
  checksum       = ''
  checksumType   = ''
  checksum64     = ''
  checksumType64 = ''
  silentArgs     = '/S'
  validExitCodes = @(0)
}

$fileName = @{$true=($packageArgs.url);$false=($packageArgs.url64)}[ ((Get-OSBitness) -eq 32) ]
$filename = $fileName -split('/'); $filename = ( $filename[-1] ); $filename = ( $filename -replace( "\.$($packageArgs.fileType)", '' ) )

# Checking for Package Parameters
if (!$pp['WorkingDirectory']) { $pp['WorkingDirectory'] = $pp.UnzipLocation+"\$filename" }
if (!$pp['TargetPath']) { $pp['TargetPath'] = $pp['WorkingDirectory']+"\bin\${env:ChocolateyPackageTitle}.exe" }
if (!$pp['IconLocation']) { $pp['IconLocation'] = $pp['TargetPath'] }
if (!$pp['Arguments']) { $pp['Arguments'] = "" }
if (!$pp['ShortcutFilePath']) { $pp['ShortcutFilePath'] = ( [Environment]::GetFolderPath('Desktop') )+"\${env:ChocolateyPackageTitle}.lnk" }
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

if ($pp['Taskbar']) { $packageParams.Add( 'PinToTaskbar', $true ) }
if ($pp['Admin']) {  $packageParams.Add( 'RunAsAdmin', $true ) }

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
