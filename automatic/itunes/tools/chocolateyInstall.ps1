$ErrorActionPreference = 'Stop';

$version = '12.9.0.167'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/041-02279-20180912-24D8EE3A-AC7A-11E8-BE19-C36F1B1141A5/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/041-02280-20180912-24D8CF68-AC7A-11E8-8B51-C26F1B1141A5/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '8DA31513D276AB82F3F9FDFEB28CE2ED127A648BE02AE7AEEF7470044766F480'
  checksumType   = 'sha256'
  checksum64     = 'e366b102f8b57958cd14457dbf3762322da6d86a044fc8e6d2a66e6d605347be'
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
