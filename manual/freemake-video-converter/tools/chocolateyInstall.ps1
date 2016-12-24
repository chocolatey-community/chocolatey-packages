$packageArgs = @{
  packageName   = 'freemake-video-converter'
  installerType = 'exe'
  silentArgs    = '/VERYSILENT /NORESTART'
  url           = 'http://packages.chocolatey.adam.gabrys.biz/freemake-video-converter/freemake-video-converter-4.1.9.45.exe'
  checksum      = '77338f53643e40e864da5539b6629b8d'
  checksumType  = 'md5'
}

Install-ChocolateyPackage @packageArgs
