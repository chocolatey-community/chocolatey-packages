$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/1.9.6/vagrant_1.9.6_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/1.9.6/vagrant_1.9.6_x86_64.msi'
  checksum       = '63e1842d13b84cf1c677d4d95006aa341481d3cbde6cea73bf448f3af9e0a77d'
  checksum64     = '3b68fc8977d8322d018b856fae59be5eb791ad447c9258a70ff0b7db9593c871'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs
