$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.0.4/vagrant_2.0.4_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.0.4/vagrant_2.0.4_x86_64.msi'
  checksum       = '41a114cd0afdef6ed438b836c8ed0bc7916ae7570629c98f4360478118f16153'
  checksum64     = 'ae971c8bbc7507b266b3c4c33d2ecd4c62a47c5520f5541158e573adba70f61a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs
