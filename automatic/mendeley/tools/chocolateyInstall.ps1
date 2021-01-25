$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'mendeley'
  fileType       = 'EXE'
  url            = 'https://desktop-download.mendeley.com/download/Mendeley-Desktop-1.19.8-win32.exe'
  checksum       = '99b308cda0047bdaae8727ebd92b7ce6c8342fe794732b61313db5444cf69f4f'
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
