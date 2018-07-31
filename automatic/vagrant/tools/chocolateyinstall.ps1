$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.1.2/vagrant_2.1.2_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.1.2/vagrant_2.1.2_x86_64.msi'
  checksum       = '7e058165f0e2246a6dd098fa36e24c2623b28515d4e31f961ff3df0de1b44ed2'
  checksum64     = '492e01d5ef25bf97a5ba157d6ae2101e54f1b6965f41f05c5299dc701dc73182'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs

Update-SessionEnvironment
vagrant plugin repair  #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1024
