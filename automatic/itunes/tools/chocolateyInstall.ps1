$ErrorActionPreference = 'Stop';

$version = '12.9.1.4'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/041-13372-20181024-3F5AEEE2-D7EB-11E8-9F46-F296F34A5CAA/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/041-13378-20181024-3F5B4748-D7EB-11E8-AD60-F196F34A5CAA/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '9AB6AA93AE630454CF0BF5C5B3DC1CBB191A767729EB5E66434F622992E608CE'
  checksumType   = 'sha256'
  checksum64     = 'cf49c5d17901ce0814ee7ec10ec21d1673cb8bddb096b8e6d811074cefca30ac'
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
