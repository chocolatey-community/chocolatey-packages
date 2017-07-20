$ErrorActionPreference = 'Stop';

$version = '12.6.2'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/091-22849-20170719-8AC5248C-6BB9-11E7-A52A-C7374A4DD6D5/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/091-22850-20170719-8AC53D14-6BB9-11E7-A878-C6374A4DD6D5/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '848cc7785784c6f25b78015c2e4c70ac17f231ce90fc66fa134752f78801feee'
  checksumType   = 'sha256'
  checksum64     = '1cacadb282960c3428af3122b66e7bb59cb7bf94b5f6764c4a0715f5635d134f'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 2010, 1641)
  unzipLocation  = Get-PackageCacheLocation
}

$app = Get-UninstallRegistryKey -SoftwareName $packageArgs.softwareName | select -first 1

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
