$packageArgs = @{
  packageName    = 'partitionmasterfree'
  fileType       = 'EXE'
  url            = 'http://download.easeus.com/free/epm.exe'
  checksum       = '77c9329df7ff694015094cc9e4b017666d968c764ec3dd3216b6cef7dcd94bf0'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  softwareName   = 'EaseUS Partition Master (Free)'
}

Write-Host "This package is not completely silent." -ForegroundColor "White"
Write-Host "The application will launch after installation." -ForegroundColor "White"

Install-ChocolateyPackage @packageArgs
