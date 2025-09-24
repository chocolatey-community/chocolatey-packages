$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://app.gomtv.com/gom/GOMPLAYERKORSETUP.EXE'
  softwareName   = 'GOM Player'
  checksum       = 'cb3536dbab7b41d6eedc22302df16864b2f482931878aa1450fbc79df9ec71af'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
