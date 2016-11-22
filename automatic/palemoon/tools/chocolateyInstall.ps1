$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://relmirror.palemoon.org/release/palemoon-27.0.0.win32.installer.exe'
  url64         = 'http://relmirror.palemoon.org/release/palemoon-27.0.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '11a97ed8117dd5b9f51595281221d53bd7bdb890f04de822d67ab960c8a3ba17'
  checksumType  = 'sha256'
  checksum64    = '2db48606d38202212c2e9cef8b8cecacfdb27c36c2839ecd80b6b0890d3cd4c8'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
