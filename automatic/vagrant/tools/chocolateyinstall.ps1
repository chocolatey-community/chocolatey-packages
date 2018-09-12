$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.1.5/vagrant_2.1.5_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.1.5/vagrant_2.1.5_x86_64.msi'
  checksum       = 'eecb0734e3cfc4951fe1be61ee313230edb36186e269c4e4c062604605d67e47'
  checksum64     = 'ae1221b1489afc03b5782acb8feb91dd26b847bc4aad336f769f9242fde6d373'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs

Update-SessionEnvironment

$ErrorActionPreference = 'Continue' #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1099
vagrant plugin repair               #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1024
if ($LastExitCode -ne 0) {          #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1099
  Write-Host "WARNING: Plugin repair failed, run 'vagrant plugin expunge --reinstall' after rebooting."
}
$LastExitCode = 0
