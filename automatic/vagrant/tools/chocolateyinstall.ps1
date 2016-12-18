$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1.msi'
  checksum       = 'db1fef59dd15ac90b6f5cfad20af7e15eccd814556a81f46e5422386166789a6'
  checksumType   = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs
