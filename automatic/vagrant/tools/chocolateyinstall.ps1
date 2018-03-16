$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.0.3/vagrant_2.0.3_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.0.3/vagrant_2.0.3_x86_64.msi'
  checksum       = '04cd8eeecbd2430c2f8e25ef6dfa3c59941e4a41e062af44c233a03998fb7b6d'
  checksum64     = 'fca2364f30352a4d88e4e073ba40ba56321c32659c4ed327556a9c1aa327f848'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs
