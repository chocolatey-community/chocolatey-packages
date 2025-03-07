$ErrorActionPreference = 'Stop';

$version = '12.13.6.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/072-96980-20250305-91FD8F87-ED20-4A94-8C1D-BFBF566685AC/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/072-96984-20250305-4DF668E9-3795-49F2-9C47-BFE2DBC9BA8E/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'C762F0576141A1DBDCC5B60744C4405D738FBE62CDAE7BC98C6B0F6F60AC99B5'
  checksumType   = 'sha256'
  checksum64     = 'd0b744a580f812d982c0ae0aea863373b900cd68f5e3a5f7e55c4c602f0ac7cc'
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
