$ErrorActionPreference = 'Stop';

$version = '12.9.6.3'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/041-91766-20190722-23A63A14-ACCD-11E9-B9B0-EE33FA8CF68F/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/041-91768-20190722-23A74ABC-ACCD-11E9-B0FC-EF33FA8CF68F/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '45D4C8C5ADC70A7F25DB4E548E5D1820884B24F241C0C3DE47FBDAD599CEDDB6'
  checksumType   = 'sha256'
  checksum64     = '7238cc7daf90a9afaf189888a04e2741484971486cc4c29b867c778f294211c3'
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
