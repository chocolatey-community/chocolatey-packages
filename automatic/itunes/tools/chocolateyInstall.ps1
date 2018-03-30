$ErrorActionPreference = 'Stop';

$version = '12.7.4'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/091-45190-20180123-72201368-FFEA-11E7-9647-F02911B39B62/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/091-45357-20180123-72201840-FFEA-11E7-92F9-85B67CCC33A9/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'c3147ef05ff16d3ea65ed07374958b494355ea378351defc9fea25698e4f617f'
  checksumType   = 'sha256'
  checksum64     = '25f2dbb9676724b9e4757e660c5eff14475e737c33f9b617222b9979eb2ca21b'
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
