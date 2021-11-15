$ErrorActionPreference = 'Stop';

$version = '12.12.2.2'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/002-16266-20211027-F51BB8E4-FD1E-4D0E-B200-C422BF20C491/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/002-16263-20211027-C3421E95-F58B-4691-BD76-672A0D346AFB/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '72D0CC83A571C1293C68C00E042068A76DA3DC96BC7DD1044AAE441F307868E0'
  checksumType   = 'sha256'
  checksum64     = 'fe8c80c742dbdfa8ca9967cc9e6b0cb9ea20ba07ef3a4a13f57e8cf79e4a7b18'
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
