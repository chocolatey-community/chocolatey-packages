$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'lightworks'
  fileType               = 'EXE'
  url                    = ''
  url64bit               = 'https://cdn.lwks.com/releases/2020.1.1/lightworks_2020.1.1_r124942_64bit_setup.exe'
  checksum               = ''
  checksum64             = '27d1f7ef922638a62fea38c7a1918d51a0e75c7408ab213835e1f09016f51b66'
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
