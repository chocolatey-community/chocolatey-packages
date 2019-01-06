$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'aptana-studio'
  fileType       = 'exe'
  softwareName   = 'Aptana Studio'

  checksum       = '5b3640243d3451514f2a6e869ea574a704590bbb8dfdd352bfd6c3d5993b173e'
  checksumType   = 'sha256'
  url            = 'https://github.com/aptana/studio3/releases/download/3.7.2.201807301111/Aptana_Studio_3_Setup.exe'

  silentArgs     = '/exenoui /quiet'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
