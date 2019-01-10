$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.2.3/vagrant_2.2.3_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.2.3/vagrant_2.2.3_x86_64.msi'
  checksum       = '29a3876cf3111ba22f1ce99fc0a7beb9c133e8df7b3cabfe17ec3ac403c2048a'
  checksum64     = '4ac00cd17e9de3294e3d9bbec68404b9bd09c20b91f78cbb73745f0b8f01b793'
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
