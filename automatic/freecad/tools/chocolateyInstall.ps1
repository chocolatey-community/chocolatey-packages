$ErrorActionPreference = 'Stop';

if (!$PSScriptRoot) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\helper.ps1"

$packageArgs = @{
  packageName    = 'freecad.portable'
  fileType       = '7z'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.18.4/FreeCAD-0.18.4.980bf90-WIN-x32-portable.7z'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.19.3/FreeCAD-0.19.3.6530e36-WIN-x64-portable.7z'
  softwareName   = 'FreeCAD'
  checksum       = 'E043B4DDF4402BA50312B914FCF3ED114BA48FFC7B38F347DFDDA2254E1E7874'
  checksumType   = 'sha256'
  checksum64     = '8B7CA7385F269E3253EF82408330190654CEE46A0EE6BB42C391A560CB01393C'
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
  $files = get-childitem $pp.WorkingDirectory -filter "*.exe" -recurse
  foreach ($file in $files) {
    if ( $file -notmatch "freecad" ) {
      $file = $file.Fullname
      New-Item "$file.ignore" -type "file" -force | Out-Null # Generate an ignore file(s)
    }
  }
}
else {
  Install-ChocolateyPackage @packageArgs
}
