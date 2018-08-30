$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.1.3/vagrant_2.1.3_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.1.3/vagrant_2.1.3_x86_64.msi'
  checksum       = 'a71ecd1e5415723331591e93a7675a3b6c70d783060decacd995a17179795ad0'
  checksum64     = 'bb127bbdff61b7088c987a5e88332a0fd81cd6b2a7e400ec221149de9313645d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs

Update-SessionEnvironment
vagrant plugin repair  #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1024
