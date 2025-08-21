$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9_windows_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9_windows_amd64.msi'
  checksum       = '6a093c498f4a568d0ce4f6170779fdd55ef5ee1707b33de1d88b9ffce6489207'
  checksum64     = '3bdd967927705872a70c7c98e0576afd5acd9dd73b527695f4d9dd75dd26cbe3'
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
