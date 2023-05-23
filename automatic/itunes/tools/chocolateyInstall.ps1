$ErrorActionPreference = 'Stop';

$version = '12.12.9.4'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/032-75919-20230522-6B7A256F-6541-48EC-AA40-60D621885783/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/032-75918-20230522-C36EFAE8-4B60-4DFC-AA7F-221E3BC91803/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'A9643218A6E9384548E8D449D4686252CB9F21D260EA6E73A1468D97D89C1DE9'
  checksumType   = 'sha256'
  checksum64     = '825724b11840baa477f5284e1487a62a6856b373221b0bcfe511f16ef882da93'
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
