$ErrorActionPreference = 'Stop';

$version = '12.13.1.3'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/042-92439-20231213-99D32FA3-9E6E-4444-ADB4-FE61BB83716E/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/042-92440-20231213-DDE54149-6537-4DB9-97D6-69413CD6CF86/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'CD6891AFADA9F940BC551A215A6C40F51A93B140026375BD30B1EE686DC73BD2'
  checksumType   = 'sha256'
  checksum64     = '541c30b2d72705afe75649f97e3daf677b8576e6e73d6f78f7265a0ded61011f'
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
