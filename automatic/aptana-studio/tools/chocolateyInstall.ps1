$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'aptana-studio'
  fileType       = 'exe'
  softwareName   = 'Aptana Studio'

  checksum       = 'ef2c4d58da16455bd4849d23f91825eec553fe419729260878d28e0eb131203c'
  checksumType   = 'sha256'
  url            = 'https://github.com/aptana/studio3/releases/download/v3.6.1/Aptana_Studio_3.6.1_Setup.exe'

  silentArgs     = '/exenoui /quiet'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
