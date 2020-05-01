$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://download.gimp.org/mirror/pub/gimp/v2.10/windows/gimp-2.10.18-setup-2.exe'
  softwareName   = 'GIMP'
  checksum       = 'bf6ce59587e63e1e8bab923e7dfdaa0f2c8bd3ac4d0ced602f3c063f9e32465c'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /RESTARTEXITCODE=3010 /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
