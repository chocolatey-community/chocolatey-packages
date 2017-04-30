$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'mendeley'
  fileType       = 'EXE'
  url            = 'http://desktop-download.mendeley.com/download/Mendeley-Desktop-1.17.8-win32.exe'
  checksum       = 'a62d60770b427a3ca79392746b63d7cf9c37dc26d50c27bff0d1e6cdc87e3d37'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
  softwareName   = 'Mendeley Desktop'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation) { 
  Write-Warning "Can't find $packageName install location"
  return 
}
Write-Host "$packageName installed to '$installLocation'"
