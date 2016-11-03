$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'lightworks'
  fileType               = 'EXE'
  url                    = 'http://downloads.lwks.com/lightworks_v12.6.0_full_32bit_setup.exe'
  url64bit               = 'http://downloads.lwks.com/lightworks_v12.6.0_full_64bit_setup.exe'
  checksum               = '33f7613b40780937c77a8185f83a2bdfbe62f5f4368103e3e5be2f3e5d4eb888'
  checksum64             = 'b2edef5a0db9c9d6e467cc529882056948fde0360c89978a2fe190dcd8e4c6c7'
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
