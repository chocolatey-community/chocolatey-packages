$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'codeblocks'
  fileType       = 'exe'
  softwareName   = 'CodeBlocks'
  url            = ''
  url64          = ''
  checksum       = ''
  checksumType   = 'SHA256'
  checksum64     = ''
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
