$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://downloads.mixxx.org/mixxx-2.2.4/mixxx-2.2.4-win32.exe'
  url64bit       = 'https://downloads.mixxx.org/mixxx-2.2.4/mixxx-2.2.4-win64.exe'

  softwareName   = 'Mixxx *'

  checksum       = 'af6fbce38e90a5b2f4e6d5a13912418cb461643432a74c90d292fdea5331b4527d026a11f4078e2775c943bdf5352a47297eaa351d7fe7e5eb1a3f10a554370e'
  checksumType   = 'sha512'
  checksum64     = 'ede500af569a8ac1197e0055db54e0d561613ffde8b013302a4f6f1eac3274524cf3ecca15002f5a892d01831aea3d2f932275c1d0c474f197ce72e531299b54'
  checksumType64 = 'sha512'

  silentArgs     = '/quiet'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
