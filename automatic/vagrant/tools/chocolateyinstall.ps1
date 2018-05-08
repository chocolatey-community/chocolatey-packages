$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.1.1/vagrant_2.1.1_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.1.1/vagrant_2.1.1_x86_64.msi'
  checksum       = '00c6715341cd2f94694956de3810ecf89a1bb66ef5c42777d3fb923bd391394d'
  checksum64     = '0a1267ca0fbfc768a2f8ae6c5d70e9bbdb95ea960eb2be5d524a327ccb32b20c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs

Update-SessionEnvironment
vagrant plugin repair  #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1024
