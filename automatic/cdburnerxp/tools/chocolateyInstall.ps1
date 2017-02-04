$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'cdburnerxp'
  fileType               = 'msi'
  url                    = 'https://download.cdburnerxp.se/msi/cdbxp_setup_4.5.7.6521.msi'
  url64bit               = 'https://download.cdburnerxp.se/msi/cdbxp_setup_x64_4.5.7.6521.msi'
  checksum               = 'c38d057b27fa8428e13c21bd749ef690b4969fab14518fb07c99ad667db6167e'
  checksum64             = '3a665bcbaa60c229303a2676507d4753089a03cfe5e890f7c72fe83e298fa153'
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
