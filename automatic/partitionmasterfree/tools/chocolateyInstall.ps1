$packageArgs = @{
  packageName    = 'partitionmasterfree'
  fileType       = 'EXE'
  url            = 'http://download.easeus.com/free/epm.exe'
  checksum       = 'b7f82106978ee2f633796c3f6273d8b8a981d27c9419552292055329cb00cbfe'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /RESTARTEXITCODE=3010 /SP-'
  validExitCodes = @(0, 3010)
  softwareName   = 'EaseUS Partition Master*'
}

Write-Host "This package is not completely silent." -ForegroundColor "White"
Write-Host "The application will launch after installation." -ForegroundColor "White"

Install-ChocolateyPackage @packageArgs
