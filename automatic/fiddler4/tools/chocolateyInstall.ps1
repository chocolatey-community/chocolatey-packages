$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'fiddler4'
  fileType               = 'EXE'
  url                    = 'https://www.telerik.com/docs/default-source/fiddler/fiddlersetup.exe'
  checksum               = '26D87A8679C12374F0897D34449E12BD75DA434760C04F75DA0A45C62E306F4B'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'fiddler*'
}
Install-ChocolateyPackage @packageArgs
