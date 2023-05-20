$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.3.6/vagrant_2.3.6_windows_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.3.6/vagrant_2.3.6_windows_amd64.msi'
  checksum       = 'e34c7d24944ff140a9f9286ab180ba4eb23d0b20687f3128dabd64a7264f5078'
  checksum64     = '93bfd30000094b2e2408cefc900f2837604ddf5fa69c6d39a352b6678c3df61b'
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
