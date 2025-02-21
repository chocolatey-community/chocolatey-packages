$ErrorActionPreference = 'Stop';

$version = '12.13.5.3'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/072-44556-20250218-B0FBC48F-2592-4EA4-BB98-0563245FC4A8/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/072-44554-20250218-E70A4561-26A5-4110-AB7F-892AAFFCA36A/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'CB89EAE87EA012C297C891CC0A3706FD8A0CFBE5FFEF462F257BF97E4BA62F55'
  checksumType   = 'sha256'
  checksum64     = 'a8a291080c11635ad9d9300dcce6630d7fb8631fa936eee5ce372987c1233542'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 2010, 1641, 3010)
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
