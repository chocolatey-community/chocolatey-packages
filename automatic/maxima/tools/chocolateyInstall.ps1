$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'maxima'
  fileType               = 'exe'
  url                    = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.38.1-Windows/maxima-clisp-sbcl-5.38.1.exe'
  url64bit               = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.38.1-Windows/maxima-sbcl-5.38.1-win64.exe'
  checksum               = 'f6dd4c04191c6ae865181b32e9cdc502837feb3d56bd89933ca7a84e0f33c4c1'
  checksum64             = '848675602ac090ab75d8db8b065012af753ce1e325dfbef38045dc571d76429d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'maxima*'
}
Install-ChocolateyPackage @packageArgs
