$ErrorActionPreference = 'Stop';

 if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\helper.ps1"

$packageArgs = @{
  packageName    = 'freecad'
  fileType       = '7z'
  url            = ''
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.19_pre/FreeCAD_0.19.23323-Win-Conda_vc14.x-x86_64.7z'
  softwareName   = 'FreeCAD'
  checksum       = ''
  checksumType   = ''
  checksum64     = '0FC9895C2C2AAFB116BC0EB24EC009AFC8A7F09D5C03233C05B855B27E3A97FE'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

if ( $packageArgs.filetype -eq '7z' ) {
  # Checking for Package Parameters
  $pp = ( Get-UserPackageParams -scrawl )
  if ($packageArgs.url64 -match "Conda") { $packageArgs.Remove("url"); $packageArgs.Remove("checksum"); $packageArgs.Remove("checksumType"); }
  if ($pp.InstallDir) { $packageArgs.Add( "UnzipLocation", $pp.InstallDir ) }
  Install-ChocolateyZipPackage @packageArgs
  if ($pp.Shortcut) { $pp.Remove("Shortcut"); Install-ChocolateyShortcut @pp }
  $files = get-childitem $pp.WorkingDirectory -Exclude $packageArgs.softwareName -include *.exe -recurse
  foreach ($file in $files) {
    New-Item "$file.ignore" -type file -force | Out-Null # Generate an ignore file(s)
  }
} else {
  Install-ChocolateyPackage @packageArgs
}
