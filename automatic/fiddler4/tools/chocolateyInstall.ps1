$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'fiddler4'
  fileType               = 'EXE'
  url                    = 'https://www.telerik.com/docs/default-source/fiddler/fiddlersetup.exe'
  checksum               = 'a22d8c8d786aae045b244256babfefb2c0ef2999c0f8ac57e77b3147ba6295b8'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'fiddler*'
}
Install-ChocolateyPackage @packageArgs
