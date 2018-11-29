$packageArgs = @{
  packageName    = 'partitionmasterfree'
  fileType       = 'EXE'
  url            = 'http://download.easeus.com/free/epm.exe'
  checksum       = 'dbb758d749dd2e874f3eca86c9a9724fb3cb4793a4dd36cf1e86e34b09a0d211'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  softwareName   = 'EaseUS Partition Master (Free)'
}

Write-Host "This package is not completely silent." -ForegroundColor "White"
Write-Host "The application will launch after installation." -ForegroundColor "White"

Install-ChocolateyPackage @packageArgs
