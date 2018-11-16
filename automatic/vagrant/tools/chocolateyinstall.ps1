$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.2.1/vagrant_2.2.1_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.2.1/vagrant_2.2.1_x86_64.msi'
  checksum       = '54eda24258bbcdff17a69344dd7a08b7c16e1d7e6892c6a578d5374c3bc72dde'
  checksum64     = '54e062d8214cdd99e792d4dc0f85f7c3ac4275d3822102992b4003590371e65f'
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
