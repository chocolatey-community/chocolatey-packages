$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'mendeley'
  fileType       = 'EXE'
  url            = 'https://desktop-download.mendeley.com/download/Mendeley-Desktop-1.17.12-win32.exe'
  checksum       = 'd92ff4ef0a5afef0a0dc8db2bdea0d85b464679e1c35321dab129130231fb287'
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
