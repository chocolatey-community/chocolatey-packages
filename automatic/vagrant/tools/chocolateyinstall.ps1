$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'vagrant'
  fileType       = 'msi'
  url            = 'https://releases.hashicorp.com/vagrant/1.9.8/vagrant_1.9.8_i686.msi'
  url64bit       = 'https://releases.hashicorp.com/vagrant/1.9.8/vagrant_1.9.8_x86_64.msi'
  checksum       = '8844a47fadd807390038f0317940f2421a4f00756ee16b16eb4681a5dc0dbb26'
  checksum64     = '3080a028d3826168befd6b6ed119514c3f93e0ff8da2cd135bde2322d174f4e9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'vagrant'
}
Install-ChocolateyPackage @packageArgs
