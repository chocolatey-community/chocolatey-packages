$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.msi'
  checksum       = 'c4f760748998598f5370ef6b4860fdaf7a66ffbe4caa8f39d87543a5b15ed136'
  checksum64     = '4e9d2617dc2e1d194cdf8c7fbdc4041cef43e770baecbadbfed6c74fc4f5b98c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs

Update-SessionEnvironment

$ErrorActionPreference = 'Continue' #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1099
vagrant plugin update               #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1358
vagrant plugin repair               #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1024
if ($LastExitCode -ne 0) {          #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1099
  Write-Host "WARNING: Plugin repair failed, run 'vagrant plugin expunge --reinstall' after rebooting."
}
$LastExitCode = 0
