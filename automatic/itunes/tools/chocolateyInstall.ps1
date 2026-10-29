$ErrorActionPreference = 'Stop';

$version = '12.13.12.3'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/142-28288-20261026-a76b3377-3407-4ee8-b601-877f7ba3ca1a/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/142-28289-20261026-6acff6c8-72eb-4045-84eb-fd35239ac645/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '227E0B9EC37ADEC3067984069A2983D054D7801255BF8AD4CD2CB00E78397A78'
  checksumType   = 'sha256'
  checksum64     = '221a24203f6182b7dc0e18055b1e9338a0c3c992c7fefe6b3be0460caf29db4d'
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
