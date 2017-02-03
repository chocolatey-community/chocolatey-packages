$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'cdburnerxp'
  fileType               = 'msi'
  url                    = 'https://download.cdburnerxp.se/msi/cdbxp_setup_4.5.7.6499.msi'
  url64bit               = 'https://download.cdburnerxp.se/msi/cdbxp_setup_x64_4.5.7.6499.msi'
  checksum               = 'd6065252bafef4cef40904de0af2590656cab50817bfb527bc4e76ae6115877d'
  checksum64             = 'ed4d5abaa003ce52461424ef227b67bc95ad4659791157074e226c178aee5b8c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  softwareName           = 'cdburnerxp*'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\cdbxpp.exe"
    Write-Host "$packageName registered as cdbxpp"
}
else { Write-Warning "Can't find $PackageName install location" }
