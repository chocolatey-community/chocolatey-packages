$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.2.11/vagrant_2.2.11_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.2.11/vagrant_2.2.11_x86_64.msi'
  checksum       = 'ba2d4814574357ce862510f62317278dd6312b5f243ed95754116923746811c6'
  checksum64     = 'f866fd75845fbff1558f9fa9246fd3210c447a784cfb38774b45ea6195260241'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs

Update-SessionEnvironment

$ErrorActionPreference = 'Continue' #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1099

#https://github.com/chocolatey/chocolatey-coreteampackages/issues/1358
$proxy = Get-EffectiveProxy
if ($proxy) {
  Write-Host "Setting CLI proxy: $proxy"
  $env:http_proxy = $env:https_proxy = $proxy
}
vagrant plugin update

vagrant plugin repair               #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1024
if ($LastExitCode -ne 0) {          #https://github.com/chocolatey/chocolatey-coreteampackages/issues/1099
  Write-Host "WARNING: Plugin repair failed, run 'vagrant plugin expunge --reinstall' after rebooting."
}
$LastExitCode = 0
