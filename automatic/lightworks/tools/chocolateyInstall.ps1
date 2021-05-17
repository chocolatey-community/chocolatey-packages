$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'lightworks'
  fileType               = 'EXE'
  url                    = ''
  url64bit               = 'https://cdn.lwks.com/releases/2021.2/lightworks_2021.2_r128258_64bit_setup.exe'
  checksum               = ''
  checksum64             = '9f3dfa9e375e975359d637179cb60ba23c999c8855ad109af129bb7ace2234e3'
  checksumType           = ''
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
