$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'lightworks'
  fileType               = 'EXE'
  url                    = 'https://downloads.lwks.com/v14-5/lightworks_v14.5.0_full_32bit_setup.exe'
  url64bit               = 'https://downloads.lwks.com/v14-5/lightworks_v14.5.0_full_64bit_setup.exe'
  checksum               = 'a921c043b01d8804fc1365580a4cf29a4022d1812d1d5101d33eccc5fc978921'
  checksum64             = '55b75aa1d8c35a49920576f59c4a9f336c9fa0498c8a0c580e2c2004ece594af'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Lightworks'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
