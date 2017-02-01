$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'ietester'
  fileType       = 'exe'
  url            = 'http://www.my-debugbar.com/ietester/install-ietester-v0.5.4.exe'
  softwareName   = 'IETester*'
  checksum       = 'bf3b91b5e5a0c1e799636a0d2d9cf0991a7b6a00a2fed2eaebe2678b9d0655e4'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
