$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'cdburnerxp'
  fileType               = 'msi'
  url                    = 'https://download.cdburnerxp.se/msi/cdbxp_setup_4.5.7.6389.msi'
  url64bit               = 'https://download.cdburnerxp.se/msi/cdbxp_setup_x64_4.5.7.6389.msi'
  checksum               = '859b8b15140d99c956a731ebab099de20842eb54d2dc72029fb9b3e2797ed03f'
  checksum64             = 'ec37738e8cf17f5fdcad172cf27f09bf71d892dd5afa25e175ef3d04bcfc1c21'
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
