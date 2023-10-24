$ErrorActionPreference = 'Stop';

$version = '12.13.0.9'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/042-62514-20231023-50B51FD0-68B9-4F27-989D-B226D7A42BEC/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/042-62516-20231023-4B775F51-D1D0-4728-A168-77A5EFB3D51D/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'B29C86AAA25A5DD6473293F7CF12310F9F8F405E80CC466F2591FE5CD91F504D'
  checksumType   = 'sha256'
  checksum64     = '9659783e209012386d6654ce448d58cf9a77efd9cf1d71aa767c9da08ca9adcf'
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
