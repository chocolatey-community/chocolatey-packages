$ErrorActionPreference = 'Stop';

$version = '12.9.4.102'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/041-44314-20190325-EF43BF3A-4E71-11E9-ACE6-794824A43337/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/041-44313-20190325-EF444F04-4E71-11E9-8702-7A4824A43337/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '9D4B498A2DB1C71AE2118AC8E3C84848C766823288994A68FC363D96D97D87E1'
  checksumType   = 'sha256'
  checksum64     = '5022bda75d937f2c0b2d39e90d649bbe1460e4e5667c1d6d550ef1beceba0f12'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 2010, 1641)
  unzipLocation  = Get-PackageCacheLocation
}

$app = Get-UninstallRegistryKey -SoftwareName $packageArgs.softwareName | Select-Object -first 1

if ($app -and ([version]$app.DisplayVersion -ge [version]$version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "iTunes $version or higher is already installed."
  Write-Host "No need to download and install again"
  return;
}

Install-ChocolateyZipPackage = @packageArgs

$msiFileList = (Get-ChildItem -Path $packageArgs.unzipLocation -Filter '*.msi' | Where-Object {
  $_.Name -notmatch 'AppleSoftwareUpdate*.msi'
})

foreach ($msiFile in $msiFileList) {
  $packageArgs.packageName = $msiFile.Name
  $packageArgs.file = $msiFile.FullName
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item $packageArgs.unzipLocation -Recurse -Force -ea 0
