$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.0.2/vagrant_2.0.2_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.0.2/vagrant_2.0.2_x86_64.msi'
  checksum       = '1e0de3a5907d38df4ad554cffb22b046649e29629302b9d09ff58f0e39982d4b'
  checksum64     = '2ae003443732c8e2000c2c7088cead9e97411a84fe0a92f7ce8c8d2f9277e8a5'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs
