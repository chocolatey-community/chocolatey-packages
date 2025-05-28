$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO9.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO9-x64.exe'
  checksum               = '2b4a943ac1889a1acf9936a301fb8443d40036f5d392ae0ccc7660229106c44a'
  checksum64             = 'a2e074c8ab8c4a04cc1195df3adf3abe9a6c2aa9229a8e3a1f121baf3a67e6b3'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
