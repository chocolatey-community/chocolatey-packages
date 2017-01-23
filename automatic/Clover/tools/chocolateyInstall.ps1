$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'clover'
  fileType               = 'EXE'
  url                    = 'http://ejie.me/uploads/setup_clover@3.2.7.exe'
  checksum               = 'f5868b375e5c8eab86fc5ded703af7b48970cf8a3af26be34f38d0de790c6edd'
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
