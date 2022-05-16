$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    ='sauerbraten'
  fileType       = 'exe'
  softwareName   = 'Sauerbraten'

  checksum       = '89842b3fe5cf591b761b84948e97e3a68e2fa451f5a0afb102a9347efca0a41e'
  checksumType   = 'sha256'
  url            = 'https://jztkft.dl.sourceforge.net/project/sauerbraten/sauerbraten/2020_11_29/sauerbraten_2020_12_21_windows.exe'
  
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
