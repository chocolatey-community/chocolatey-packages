$packageArgs = @{
  packageName    = 'partitionmasterfree'
  fileType       = 'EXE'
  url            = 'https://download3.easeus.com/free/epm_free_installer.exe'
  checksum       = '4d607079670051ee45f5b78dee047998d6b6a8dbe2d9d3b68d3463acf38afa68'
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
