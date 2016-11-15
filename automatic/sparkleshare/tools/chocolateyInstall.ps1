$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'sparkleshare'
  fileType      = 'msi'
  url           = 'https://bitbucket.org/hbons/sparkleshare/downloads/sparkleshare-windows-1.5.msi'

  softwareName  = 'SparkleShare'

  checksum      = '7c82078c4ed912d4ac5a0d93c9a638f15b9da5332f34d5088ec27ae14ccd085c'
  checksumType  = 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
