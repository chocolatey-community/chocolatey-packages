$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.1.0/vagrant_2.1.0_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.1.0/vagrant_2.1.0_x86_64.msi'
  checksum       = '8320c93691fe529da17a43274e3ce92ddc9a0b32ca88355e28f7498e4c573759'
  checksum64     = 'de88772fc38b7dec8afb7b3f319cdc6d91fc58bc3a3fc7ee6f1bef4b294d39e5'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs
