$ErrorActionPreference = 'Stop';

$version = '12.12.8.2'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/032-43413-20230329-BB8ADBE3-B938-410E-8EE8-2B5E7B3CF65B/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/032-43416-20230329-5563B273-069B-4902-8997-39A886456E7B/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '12128124CA135C08C49B7DCC76C65688CFEB2B13A8FF994766BA395A24BDCD2B'
  checksumType   = 'sha256'
  checksum64     = 'f47b36ebd5793dbd608477075ba723ead14232a3851bad7fc0c15943f4efbf72'
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
