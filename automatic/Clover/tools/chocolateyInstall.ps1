$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'clover'
  fileType               = 'EXE'
  url                    = 'http://ejie.me/uploads/setup_clover@3.2.4.exe'
  checksum               = '204a8a6764b4cb432ecbd8e73acb104d16dd1660c5f91aa6285e5f2f1c3e955d'
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
