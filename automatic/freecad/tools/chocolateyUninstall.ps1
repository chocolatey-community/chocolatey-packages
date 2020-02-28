$ErrorActionPreference = 'Stop';

if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }

$packageArgs = @{
  packageName   = ''
  softwareName  = ''
  fileType      = ''
  silentArgs    = '/S'
  validExitCodes= @(@(0))
}

if ( $packageArgs.fileType -match 'exe' ) {
	$uninstalled = $false
	[array]$key = Get-UninstallRegistryKey @packageArgs
  if ($key.Count -eq 1) {
   $key | ForEach-Object {
   $packageArgs['file'] = "$($_.UninstallString)"
   Uninstall-ChocolateyPackage @packageArgs
   }
  } elseif ($key.Count -eq 0) {
   Write-Warning "$packageName has already been uninstalled by other means."
  } elseif ($key.Count -gt 1) {
   Write-Warning "$($key.Count) matches found!"
   Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
   Write-Warning "Please alert the package maintainer that the following keys were matched:"
   $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
  }
} else {
$pp = ( Get-Content "$PSScriptRoot\pp.json" ) | ConvertFrom-Json 
if ($pp.ShortcutFilePath) { Remove-Item -Path $pp.ShortcutFilePath }
if ($pp.InstallDir) { Remove-Item  -Path $pp.InstallDir -ErrorAction SilentlyContinue -Recurse -Force }
Write-Information "All files Removed"
}
