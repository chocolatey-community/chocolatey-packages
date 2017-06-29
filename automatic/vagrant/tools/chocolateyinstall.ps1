$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/1.9.6/vagrant_1.9.6_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/1.9.6/vagrant_1.9.6_x86_64.msi'
  checksum       = ''
  checksum64     = ''
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs
