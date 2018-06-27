$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.1.2/vagrant_2.1.2_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.1.2/vagrant_2.1.2_x86_64.msi'
  checksum       = '1563f1a8c2a0153cccebd52efc9e20c67b342bc3ae5a712ba07b444a486c2bb1'
  checksum64     = 'a572aac4df16ed9077054df73e6dc34f5782d398d6660e48b0d5eb05ae69b636'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs

Update-SessionEnvironment
vagrant plugin repair  #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1024
