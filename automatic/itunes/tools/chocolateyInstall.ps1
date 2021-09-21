$ErrorActionPreference = 'Stop';

$version = '12.12.0.6'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/071-30323-20210915-123B0E28-1678-11EC-AB36-CEF157CD27C4/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/071-30327-20210915-123B7FE8-1678-11EC-8C42-CFF157CD27C4/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'C958879020DC5BB41E26D6879AC7D14C4AE920186D6F8E84845765C4C27E96E6'
  checksumType   = 'sha256'
  checksum64     = '76fcc844621a9e87f158784b657dd9a2198251e2d8bdf62f7f242262c276ea63'
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

Install-ChocolateyZipPackage @packageArgs

$msiFileList = (Get-ChildItem -Path $packageArgs.unzipLocation -Filter '*.msi' | Where-Object {
  $_.Name -notmatch 'AppleSoftwareUpdate*.msi'
})

foreach ($msiFile in $msiFileList) {
  $packageArgs.packageName = $msiFile.Name
  $packageArgs.file = $msiFile.FullName
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item $packageArgs.unzipLocation -Recurse -Force -ea 0
