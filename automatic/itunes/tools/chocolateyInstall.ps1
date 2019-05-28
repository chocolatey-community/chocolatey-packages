$ErrorActionPreference = 'Stop';

$version = '12.9.5.7'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/041-22633-20190522-F739CF72-7CCA-11E9-8EBA-3BB3FCE95627/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/041-22642-20190522-DEF96194-7CC9-11E9-8173-5AB2FCE95627/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '7FC1092FD10BBDF8F7C05053B1FF81D734C619B833600ECA374A9DDDB9870080'
  checksumType   = 'sha256'
  checksum64     = '5505024bceea89ca364cdc98eaadb356f024513f9838d4a0b57527536b05deea'
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
