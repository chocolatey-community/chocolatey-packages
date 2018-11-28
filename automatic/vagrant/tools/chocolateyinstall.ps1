$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.2.2/vagrant_2.2.2_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.2.2/vagrant_2.2.2_x86_64.msi'
  checksum       = 'd3e7a9f11e8312fc0f8b6d647126b869cfb54e9ba42c9cf74c1241d2d8a82660'
  checksum64     = '6b3f76e3a8c63a53e89981f556863c3508635785a8b04e6b04eaea8efe8aefa5'
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
