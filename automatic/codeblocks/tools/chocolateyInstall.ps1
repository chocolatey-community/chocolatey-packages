$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'codeblocks'
  fileType       = 'exe'
  softwareName   = 'CodeBlocks'
  url            = 'https://sourceforge.net/projects/codeblocks/files/Binaries/25.03/Windows/32bit/codeblocks-25.03mingw-32bit-setup.exe'
  url64          = 'https://sourceforge.net/projects/codeblocks/files/Binaries/25.03/Windows/codeblocks-25.03mingw-setup.exe'
  checksum       = '7830e8e19b3eec2657b931b52f417dbbf55cadc3d9dfe21151db058994f54df6'
  checksumType   = 'SHA256'
  checksum64     = '8712227526eb3bb26c90dd5c78301b3fa32bf5869a43294bbf4e9c5512c52792'
  checksumType64 = 'SHA256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$($packageArgs.packageName) installed to '$installLocation'"
  Register-Application "$installLocation\codeblocks.exe"
}
