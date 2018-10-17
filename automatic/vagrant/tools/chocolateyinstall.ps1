$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.2.0/vagrant_2.2.0_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.2.0/vagrant_2.2.0_x86_64.msi'
  checksum       = 'f6c12594e2247d4c53b4616f8088e59754b77c5c2c0a0dc4b267ac4c87fb0ea2'
  checksum64     = '5be450b7a1c89f8a44ccef88c2a737fd7973cbf528e5279772966ea0c7683567'
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
