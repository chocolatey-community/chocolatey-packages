$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'mumble'
  fileType               = 'msi'
  url                    = 'https://github.com/mumble-voip/mumble/releases/download/1.2.18/mumble-1.2.18.msi'
  checksum               = '489adb72e9a84f9ac3ff55441f174ae989e89e56f9fe4e900f5dc7875bdbd05e'
  checksumType           = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0)
  softwareName           = 'mumble*'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
