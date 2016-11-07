$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'mumble'
  fileType               = 'msi'
  url                    = 'https://github.com/mumble-voip/mumble/releases/download/1.2.17/mumble-1.2.17.msi'
  checksum               = 'f6a47baf4418ee78658c60e93a605dbdd804739a27cf027233adda6132a24d45'
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
