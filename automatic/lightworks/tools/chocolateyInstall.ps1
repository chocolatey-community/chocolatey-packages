$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'lightworks'
  fileType               = 'EXE'
  url                    = ''
  url64bit               = 'https://cdn.lwks.com/releases/2021.1/lightworks_2021.1_r126716_64bit_setup.exe'
  checksum               = ''
  checksum64             = '2f452ae04b59ac5ea28363801497a0cc32388b8e786dc2d0cd8cda286426a340'
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
