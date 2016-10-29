$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'fiddler4'
  fileType               = 'EXE'
  url                    = 'https://www.telerik.com/docs/default-source/fiddler/fiddlersetup.exe'
  checksum               = 'd81509447329b7384926a55a16e1c807aebdf787c3d6b6c43bb59c6fde501555'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'fiddler*'
}
Install-ChocolateyPackage @packageArgs
