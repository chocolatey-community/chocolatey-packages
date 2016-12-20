$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'cdburnerxp'
  fileType               = 'msi'
  url                    = 'https://download.cdburnerxp.se/msi/cdbxp_setup_4.5.7.6452.msi'
  url64bit               = 'https://download.cdburnerxp.se/msi/cdbxp_setup_x64_4.5.7.6452.msi'
  checksum               = '1090f7a9033567cf2bc63ff6e404d766172f4aaf35b79b515e12f06cd9eb35e6'
  checksum64             = '33949797be632ed9eb0bcc8cd9f43e1096ce8f2bd7a2b43c778a2ed249c9d13d'
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
