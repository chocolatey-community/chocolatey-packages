$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'mendeley'
  fileType       = 'EXE'
  url            = 'https://desktop-download.mendeley.com/download/Mendeley-Desktop-1.17.11-win32.exe'
  checksum       = '8bf16872183f074c9b50e0e9e7d3e1d7935b88f3099b738c0604cbfb41c79710'
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
