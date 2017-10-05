$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'maxima'
  fileType               = 'exe'
  url                    = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.41.0-Windows/maxima-clisp-sbcl-5.41.0-win32.exe'
  url64bit               = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.41.0-Windows/maxima-clisp-sbcl-5.41.0-win64.exe'
  checksum               = '7d767879824590816ba3ba7c24ed2f494071b69a480df3e8e88288b67091f914'
  checksum64             = '1fdbd75c9e67840924b61796fb4771a9fb19ab3ecf2b4c28e6f0c1fb0f6f6dbc'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'maxima*'
}
Install-ChocolateyPackage @packageArgs
