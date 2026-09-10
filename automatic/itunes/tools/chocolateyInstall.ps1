$ErrorActionPreference = 'Stop';

$version = '12.13.11.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/140-75771-20260908-a39b30bb-de3b-4960-bba4-ae3be1e1cadd/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/140-75773-20260908-6e5e0165-99cb-4b30-b541-1b615fccfc1a/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'A8C2C43208087DC9D1D255E59F7D3EEFB452A0EC6B97A627C4F7478F6D8734E6'
  checksumType   = 'sha256'
  checksum64     = '25b28905a81406a5edbf482f7f3ee4831a8641d32d29dceda5d1eb3e8d534c08'
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
