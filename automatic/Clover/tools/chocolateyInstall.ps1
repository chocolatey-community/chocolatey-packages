$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'clover'
  fileType               = 'EXE'
  url                    = 'http://ejie.me/uploads/setup_clover@3.2.7.exe'
  checksum               = '4232563fd9cb413de32f2cb0ad632d86b8c80cc5a9f5c1a4927476b6a61ba184'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'clover *'
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
