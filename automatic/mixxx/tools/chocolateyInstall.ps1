$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://downloads.mixxx.org/mixxx-2.2.1/mixxx-2.2.1-win32.exe'
  url64bit       = 'https://downloads.mixxx.org/mixxx-2.2.1/mixxx-2.2.1-win64.exe'

  softwareName   = 'Mixxx *'

  checksum       = 'e063869533ad82f0ce18e1876e4deec4f6a58064ffd4e765765ca60ecf4115360f3dc476cf6ab4fb7d6f300b3050063f965349641c929e953127cfa31ffe9b25'
  checksumType   = 'sha512'
  checksum64     = 'a5ca65554b6a4c0eb7615574e645b42f144965f05721e74083df0a88de4e6332fa33af8b1f770dec4721ec6393754ad1d8dc7cd0b4dfa313dc0a438fd6e544d1'
  checksumType64 = 'sha512'

  silentArgs     = '/quiet'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
