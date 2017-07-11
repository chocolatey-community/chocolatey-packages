$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'cdburnerxp'
  fileType               = 'msi'
  url                    = 'https://download.cdburnerxp.se/msi/cdbxp_setup_4.5.7.6623.msi'
  url64bit               = 'https://download.cdburnerxp.se/msi/cdbxp_setup_x64_4.5.7.6623.msi'
  checksum               = 'e4f35b5948b92a02b4f0e00426536dc65e3c28b200f2a9c8f3e19b01bff502f3'
  checksum64             = 'b73e4fc3843aba9f9a1d8ecf01e52307b856e088fb4f6a5c74e52d0f9db25508'
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
