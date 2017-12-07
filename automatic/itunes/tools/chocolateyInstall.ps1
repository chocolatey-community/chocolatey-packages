$ErrorActionPreference = 'Stop';

$version = '12.7.2'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/091-31208-20171206-1A6C2168-DABD-11E7-AB98-609461E0607F/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/091-31216-20171206-1A6C2208-DABD-11E7-AB98-5F9461E0607F/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'a19c29b0d102cf3673671cae3a326dc36ae22aa109673872fc42ce8fe3f5a899'
  checksumType   = 'sha256'
  checksum64     = '7cd6cc4da573dd5e4ba09e7710c2b97fb8e3ab4f2bcf729908ba26bd21aac388'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 2010, 1641)
  unzipLocation  = Get-PackageCacheLocation
}

$app = Get-UninstallRegistryKey -SoftwareName $packageArgs.softwareName | select -first 1

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
