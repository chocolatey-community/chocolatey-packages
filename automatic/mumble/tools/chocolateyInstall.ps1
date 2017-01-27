$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'mumble'
  fileType               = 'msi'
  url                    = 'https://github.com/mumble-voip/mumble/releases/download/1.2.19/mumble-1.2.19.msi'
  checksum               = '2186eddd99264c2e68f5425308f59bd5151a8aecebea9f852728be3487a7a93b'
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
