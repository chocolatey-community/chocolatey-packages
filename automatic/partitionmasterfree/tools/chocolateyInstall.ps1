$packageArgs = @{
  packageName    = 'partitionmasterfree'
  fileType       = 'EXE'
  url            = 'http://download.easeus.com/free/epm_e1125.exe'
  checksum       = '9e30af92f4785b3a9b64c0761e91ccafd2c81a1b5d1e476dbacd14ae53bba535'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /RESTARTEXITCODE=3010 /SP-'
  validExitCodes = @(0, 3010)
  softwareName   = 'EaseUS Partition Master*'
}

Write-Host "This package is not completely silent." -ForegroundColor "White"
Write-Host "The application will launch after installation." -ForegroundColor "White"
Write-Host "We will try to close the application." -ForegroundColor "White"

Install-ChocolateyPackage @packageArgs


Write-Host "Waiting 10 seconds for the application to start..."
Start-Sleep -Seconds 10 # We'll wait until the partition master program has started, then we will close it.

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

. "$toolsDir\helpers.ps1"
stopProcessIfExist
