$ErrorActionPreference = 'Stop'

$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$file = $registry.UninstallString
  
# All arguments for the Uninstallation of this package
$packageArgs = @{
  PackageName = $packageName
  FileType = 'exe'
  SilentArgs = '/S'
  validExitCodes = @(0)
  File = $file
}
  
Uninstall-ChocolateyPackage @packageArgs
