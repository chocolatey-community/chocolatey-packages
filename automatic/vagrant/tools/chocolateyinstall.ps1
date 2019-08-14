$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.msi'
  checksum       = '7cb6b2c1bf4c74b1b95d662e4c6c7dd2b7fbbefa0661b12f94b61eca3d80ec7d'
  checksum64     = '8716bec78764f122354d0274448bab9124629c57e226f021e65bf7041cd8c659'
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
