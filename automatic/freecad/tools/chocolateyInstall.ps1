$ErrorActionPreference = 'Stop';

if (!$PSScriptRoot) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\helper.ps1"

$packageArgs = @{
  packageName    = 'freecad'
  fileType       = 'exe'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.18.4/FreeCAD-0.18.4.980bf90-WIN-x32-installer.exe'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.19.4/FreeCAD-0.19.4-WIN-x64-installer-1.exe'
  softwareName   = 'FreeCAD*'
  checksum       = 'A3C00E00E5321D9786C56D58C501F8A8E43BA9D25F7147CD8B9C869D744BE514'
  checksumType   = 'sha256'
  checksum64     = '690CD3510677F227899A5541EC6D28B1FE1EA9AB871EE71F699CF2B665746DB2'
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
