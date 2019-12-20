$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://downloads.mixxx.org/mixxx-2.2.3/mixxx-2.2.3-win32.exe'
  url64bit       = 'https://downloads.mixxx.org/mixxx-2.2.3/mixxx-2.2.3-win64.exe'

  softwareName   = 'Mixxx *'

  checksum       = '616143ceb66c3bd6f2ddb22f69533612feed4d28e3312a2b708fef908b6a8747014bab84c986a4562a4fe8cb2ee5c55428bb39c13232e84a498751751f5e7b38'
  checksumType   = 'sha512'
  checksum64     = '32cf658920e15d4ad7603b943133da3d562b6ced67791a0eebd1fd78356a0c4763c78abbc82c95111a10eff9e7873dbd8e5dbbf85f05155e20f208953ec5a067'
  checksumType64 = 'sha512'

  silentArgs     = '/quiet'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
