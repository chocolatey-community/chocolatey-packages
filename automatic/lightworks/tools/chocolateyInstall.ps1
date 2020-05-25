$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'lightworks'
  fileType               = 'EXE'
  url                    = 'https://cdn.lwks.com/releases/lightworks_2020.1_r122068_32bit_setup.exe'
  url64bit               = 'https://lwks.s3.amazonaws.com/releases/lightworks_2020.1_r122068_64bit_setup.exe'
  checksum               = '9e1eae53642aad696a7598ee27be0db912381266654ee4394daa4e8fb6c5a594'
  checksum64             = 'd55db9340de2566de69eedc468fa7e6d0e49e2a3643193adadb2283d5fcc683d'
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
