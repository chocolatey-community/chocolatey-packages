$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/1.9.7/vagrant_1.9.7_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/1.9.7/vagrant_1.9.7_x86_64.msi'
  checksum       = '00b77ecfba84a335c0b8f183596b0858d673a56f44fad160e4f73e10cc672663'
  checksum64     = 'b600ffadfd9b390795f95a1440160ebdf52bd1fef90c6948718592f145bea365'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs
