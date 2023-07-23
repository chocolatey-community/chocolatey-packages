$ErrorActionPreference = 'Stop';

if (!$PSScriptRoot) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\helper.ps1"

$packageArgs = @{
  packageName    = 'freecad'
  fileType       = '7z'
  url            = ''
  url64          = 'https://github.com/FreeCAD/FreeCAD-Bundle/releases/download/weekly-builds/FreeCAD_weekly-builds-33631-2023-07-23-conda-Windows-x86_64-py310.7z'
  softwareName   = 'FreeCAD'
  checksum       = ''
  checksumType   = ''
  checksum64     = '5162A1061A81AC518BBBC5E6614DF4FF62BF85466C2E7E741559BEB19E891B0C'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

if (( $packageArgs.filetype -eq '7z' ) -or ( $packageArgs.filetype -eq 'zip' )) {
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
