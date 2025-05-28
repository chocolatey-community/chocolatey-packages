$ErrorActionPreference = 'Stop';

$version = '12.13.7.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/082-11725-20250331-e8250627-b79d-4280-bc70-ad22fccaf996/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/082-11723-20250331-b31ec27c-f9dd-42b1-9af3-2e2590232c09/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '12D8EDF49FED3252E86CA94304EF44556C1FB8ADC5F1832E36BB9B932BD2F99D'
  checksumType   = 'sha256'
  checksum64     = '2f5a7f4a85e24810297cb3ef63fd6d743df1c62edfc5e4ca3677c7b083bc2ff0'
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
