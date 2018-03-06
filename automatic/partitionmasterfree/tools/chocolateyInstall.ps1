$packageArgs = @{
  packageName    = 'partitionmasterfree'
  fileType       = 'EXE'
  url            = 'http://download.easeus.com/free/epm.exe'
  checksum       = '10007c4dbcc2cb24d9eda7e779b4879f223d316496a6df01f6f673c0175bb4a8'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  softwareName   = 'EaseUS Partition Master (Free)'
}

Write-Host "This package is not completely silent." -ForegroundColor "White"
Write-Host "The application will launch after installation." -ForegroundColor "White"

Install-ChocolateyPackage @packageArgs
