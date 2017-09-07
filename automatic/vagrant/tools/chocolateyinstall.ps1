$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/2.0.0/vagrant_2.0.0_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/2.0.0/vagrant_2.0.0_x86_64.msi'
  checksum       = '9e33c6e0ba25c597e963a2b514818829b9e4ce9ddaf45718be4b0a97da04afd1'
  checksum64     = '0fd2ebaf46d2d0f33a77844ed7a2116158b13872e47877bbb3929ae55d3d104f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs
