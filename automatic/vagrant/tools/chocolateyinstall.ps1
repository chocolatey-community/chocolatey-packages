$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.msi'
  checksum       = '873f579465765dbc27a6c1f363cf559d46a2c084afc534c895edafc702972920'
  checksum64     = 'd73d2200c1edc04a1988d961b0816916f052b8baa73d3e7b4f1a168a49927024'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs
