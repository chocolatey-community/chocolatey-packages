$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO6.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO6-x64.exe'
  checksum               = 'c3343ae00cd02451840c5d86ac0f96d3e397e5598a07fb85f1696fad4d04eb73'
  checksum64             = '3e5e2e52bc558e25ba00dd36856dd296d76b1ace82a5dbdd09957ce3c39aaf76'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
