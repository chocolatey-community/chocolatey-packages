$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'mendeley'
  fileType       = 'EXE'
  url            = 'https://desktop-download.mendeley.com/download/Mendeley-Desktop-1.18-win32.exe'
  checksum       = 'e1ec357497b9028a352d852d5843700c64308d8da69ceb45a4e9abdeaae71882'
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
