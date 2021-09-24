$ErrorActionPreference = 'Stop';

$version = '12.12.1.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/002-06910-20210923-55AE9DCC-1CC3-11EC-916B-326B1236DAE3/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/002-06911-20210923-55ADFFE8-1CC3-11EC-8F53-336B1236DAE3/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '30BD56C7B1467EBFEB7EF01458F5D14F83E9B0C1CB84B73A10EB4B98413E55A1'
  checksumType   = 'sha256'
  checksum64     = '3eade4a71cf3678f413b9a4ff29853580ee9b97b121f7410ed136cbdfd56effc'
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
