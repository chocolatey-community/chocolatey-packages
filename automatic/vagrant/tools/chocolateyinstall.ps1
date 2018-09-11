$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.1.4/vagrant_2.1.4_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.1.4/vagrant_2.1.4_x86_64.msi'
  checksum       = '07e7624ebe27499fd944c08bfa00fdc10f3406bde2b5f5bab61507e4abbdd94d'
  checksum64     = 'e2a25aa4834033a6e77f95edccd0d04679d75dc9cf67f5819e73f446f68058d5'
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
