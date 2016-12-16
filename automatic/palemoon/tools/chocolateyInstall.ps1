$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://relmirror.palemoon.org/release/palemoon-27.0.3.win32.installer.exe'
  url64         = 'http://relmirror.palemoon.org/release/palemoon-27.0.3.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '14fab6abe9eb9cf4d55e54f230a85ddfeedfa51cb66a602a29228a557afdac6d'
  checksumType  = 'sha256'
  checksum64    = 'fa869f9adb7d513cd2933e745b8d6f2173a97440e7c1036a0a8ce84e6414858a'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
