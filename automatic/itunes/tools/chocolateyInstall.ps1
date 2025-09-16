$ErrorActionPreference = 'Stop';

$version = '12.13.8.3'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/082-23401-20250912-ec68a900-0e3b-4eb9-a856-116e18223ddc/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/082-23400-20250912-4099b0db-ac9e-4cad-a6e7-2851fb1ec220/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'D26129BD0716C157027ABF986B89E1D0F441DC2ABB752CFA3C634EBBC6160391'
  checksumType   = 'sha256'
  checksum64     = '3c11ee5f937230bfb576705a143a5af098d87ea087a1e0f9faa3a892adf24481'
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
