$ErrorActionPreference = 'Stop';

if (!$PSScriptRoot) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\helper.ps1"

$packageArgs = @{
  packageName    = 'freecad'
  fileType       = '7z'
  url            = ''
  url64          = 'https://github.com/FreeCAD/FreeCAD-Bundle/releases/download/weekly-builds/FreeCAD_weekly-builds-31917-2023-02-16-conda-Windows-x86_64-py310.7z'
  softwareName   = 'FreeCAD'
  checksum       = ''
  checksumType   = ''
  checksum64     = 'B7E8FFA8540B4E6C3D2A4BB59689BEF5E3437F56D0BAEDDC50077AE130D0C9E3'
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
