$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'aptana-studio'
  fileType       = 'exe'
  softwareName   = 'Aptana Studio'

  checksum       = '31265389cfad9b2040f886d475f3c63834695dc75128c628ffbe32c1be2b8fa7'
  checksumType   = 'sha256'
  url            = 'https://github.com/aptana/studio3/releases/download/v3.6.1/Aptana_Studio_3_Setup_3.6.1.exe'

  silentArgs     = '/exenoui /quiet'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
